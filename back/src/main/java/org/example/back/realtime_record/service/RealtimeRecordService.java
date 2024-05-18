package org.example.back.realtime_record.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back.common.CustomException;
import org.example.back.db.entity.*;
import org.example.back.db.entity.Record;
import org.example.back.db.enums.GameMode;
import org.example.back.db.repository.*;
import org.example.back.exception.MatchingRoomNotFoundException;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.exception.RoomMemberNotFoundException;
import org.example.back.exception.RoomNotFoundException;
import org.example.back.realtime_record.dto.StompRealtimeReqDto;
import org.example.back.realtime_record.dto.SaveRealtimeRecordReqDto;
import org.example.back.redis.entity.MatchingRoom;
import org.example.back.redis.repository.MatchingRoomRepository;
import org.example.back.room.service.RoomService;
import org.example.back.util.SecurityUtil;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class RealtimeRecordService {
    private final RecordRepository recordRepository;
    private final RealtimeRecordRepository realtimeRecordRepository;
    private final MemberRepository memberRepository;
    private final MatchingRoomRepository matchingRoomRepository;
    private final RoomRepository roomRepository;
    private final RoomMemberRepository roomMemberRepository;
    private final RoomService roomService;
    private final RedisTemplate<String, String> redisTemplate;
    private final ObjectMapper objectMapper;

    @Transactional
    public List<StompRealtimeReqDto> saveRealtimeRecord(SaveRealtimeRecordReqDto saveRealtimeRecordReqDto) throws JsonProcessingException {
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        Long roomId = saveRealtimeRecordReqDto.getRoomId();
        Long recordId = saveRealtimeRecordReqDto.getRecordId();

        Record record = recordRepository.findById(recordId).orElseThrow(() -> new CustomException(HttpStatus.NOT_FOUND, recordId + "를 id로 지닌 기록이 존재하지 않습니다" ));
        GameMode gameModeEnum = record.getGameMode();

        List<StompRealtimeReqDto> stompRealtimeReqDtoList = new ArrayList<>();
        List<RealtimeRecord> realtimeRecordList = new ArrayList<>();

        ListOperations<String, String> listOperations = redisTemplate.opsForList();

        // 매칭전(배틀)
        if (gameModeEnum.name().equals("BATTLE")) {

            List<String> stringList =  listOperations.range("realtime_matchingRoomId:" + roomId + "memberId:" + myMemberId, 0, -1);

            for (String s: stringList) {
                StompRealtimeReqDto stompRealtimeReqDto = objectMapper.readValue(s, StompRealtimeReqDto.class);
                stompRealtimeReqDtoList.add(stompRealtimeReqDto);
                String nickname = stompRealtimeReqDto.getNickname();
                double distance = stompRealtimeReqDto.getDistance();
                int idx = stompRealtimeReqDto.getIdx();

                Member member = memberRepository.findByNickname(nickname).orElseThrow(MemberNotFoundException::new);

                RealtimeRecord realtimeRecord = RealtimeRecord.builder()
                        .member(member)
                        .distance(distance)
                        .idx(idx)
                        .build();

                realtimeRecordList.add(realtimeRecord);

            }

            realtimeRecordRepository.saveAll(realtimeRecordList);

            // redis에서 캐싱된 실시간 정보들을 삭제
            redisTemplate.delete("realtime_matchingRoomId:" + roomId + "memberId:" + myMemberId);

            // 저장 이후 매칭전 방에서 유저 삭제, 삭제 이후 매칭전 방에 아무도 없다면 방 삭제
            MatchingRoom matchingRoom = matchingRoomRepository.findById(roomId).orElseThrow(() -> new MatchingRoomNotFoundException(roomId));

            matchingRoom.getMembers().remove(String.valueOf(myMemberId));
            matchingRoom.getReadyMembers().remove(String.valueOf(myMemberId));

            if (matchingRoom.getMembers().isEmpty()) {
                matchingRoomRepository.deleteById(roomId);
            } else {
                matchingRoomRepository.save(matchingRoom);
            }

        }

        // 단체전(커스텀)
        else if (gameModeEnum.name().equals("CUSTOM")) {
            List<String> stringList =  listOperations.range("realtime_roomId:" + roomId + "memberId:" + myMemberId, 0, -1);
            for (String s: stringList) {
                StompRealtimeReqDto stompRealtimeReqDto = objectMapper.readValue(s, StompRealtimeReqDto.class);
                stompRealtimeReqDtoList.add(stompRealtimeReqDto);
                String nickname = stompRealtimeReqDto.getNickname();
                double distance = stompRealtimeReqDto.getDistance();
                int idx = stompRealtimeReqDto.getIdx();

                Member member = memberRepository.findByNickname(nickname).orElseThrow(MemberNotFoundException::new);

                RealtimeRecord realtimeRecord = RealtimeRecord.builder()
                        .member(member)
                        .distance(distance)
                        .idx(idx)
                        .build();

                realtimeRecordList.add(realtimeRecord);

            }

            realtimeRecordRepository.saveAll(realtimeRecordList);

            // 캐싱된 realtime data 삭제
            redisTemplate.delete("realtime_roomId:" + roomId + "memberId:" + myMemberId);

            // 실시간 정보 저장 이후, 완주한 인원을 삭제한다. 그 이후 남은 인원이 한 명도 없다면, 방을 삭제한다.
            RoomMember roomMember = roomMemberRepository.findByRoom_IdAndMember_Id(roomId, myMemberId).orElseThrow(() -> new RoomMemberNotFoundException(roomId, myMemberId));
            Long roomMemberId = roomMember.getId();

            roomMemberRepository.deleteById(roomMemberId);

            Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(roomId));

            List<RoomMember> roomMembers = room.getRoomMembers();
            roomMembers.removeIf(r -> r.getId().equals(roomMemberId));

            if (roomMembers.isEmpty()) {
                roomService.deleteRoom(roomId);
            }

        }

        // 싱글전(연습)
        else if (gameModeEnum.name().equals("PRACTICE")) {
            List<String> stringList = listOperations.range("realtime_practice_memberId:" + myMemberId, 0, -1);
            for (String s: stringList) {
                StompRealtimeReqDto stompRealtimeReqDto = objectMapper.readValue(s, StompRealtimeReqDto.class);
                stompRealtimeReqDtoList.add(stompRealtimeReqDto);
                String nickname = stompRealtimeReqDto.getNickname();
                double distance = stompRealtimeReqDto.getDistance();
                int idx = stompRealtimeReqDto.getIdx();

                Member member = memberRepository.findByNickname(nickname).orElseThrow(MemberNotFoundException::new);

                RealtimeRecord realtimeRecord = RealtimeRecord.builder()
                        .member(member)
                        .distance(distance)
                        .idx(idx)
                        .build();

                realtimeRecordList.add(realtimeRecord);

            }

            realtimeRecordRepository.saveAll(realtimeRecordList);

            // 캐싱된 realtime data 삭제
            redisTemplate.delete("realtime_practice_"  + "memberId:" + myMemberId);
            // 캐싱된 고스트의 realtime data 삭제
            redisTemplate.delete("realtime_practice_ghost:" + myMemberId);

        }

        // 만약 lastIdx와 lastDistance가 redis에 저장되어 있다면, 삭제한다
        redisTemplate.delete("lastIdx_memberId:" + myMemberId);
        redisTemplate.delete("lastDistance_memberId:" + myMemberId);

        return stompRealtimeReqDtoList;

    }

}
