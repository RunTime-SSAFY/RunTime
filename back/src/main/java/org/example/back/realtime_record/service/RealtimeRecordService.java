package org.example.back.realtime_record.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back.common.CustomException;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.RealtimeRecord;
import org.example.back.db.entity.Record;
import org.example.back.db.enums.GameMode;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RealtimeRecordRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.realtime_record.dto.StompRealtimeReqDto;
import org.example.back.realtime_record.dto.SaveRealtimeRecordReqDto;
import org.example.back.util.SecurityUtil;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class RealtimeRecordService {
    private final RecordRepository recordRepository;
    private final RealtimeRecordRepository realtimeRecordRepository;
    private final MemberRepository memberRepository;
    private final RedisTemplate<String, Object> redisTemplate;
    private final ObjectMapper objectMapper;

    public List<StompRealtimeReqDto> saveRealtimeRecord(SaveRealtimeRecordReqDto saveRealtimeRecordReqDto) throws JsonProcessingException {
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        Long roomId = saveRealtimeRecordReqDto.getRoomId();
        Long recordId = saveRealtimeRecordReqDto.getRecordId();

        Record record = recordRepository.findById(recordId).orElseThrow(() -> new CustomException(HttpStatus.NOT_FOUND, recordId + "를 id로 지닌 기록이 존재하지 않습니다" ));
        Enum<GameMode> gameModeEnum = record.getGameMode();

        List<StompRealtimeReqDto> list = new ArrayList<>();

        ListOperations<String, Object> listOperations = redisTemplate.opsForList();

        // 매칭전(배틀)
        if (gameModeEnum.name().equals("BATTLE")) {

            List<Object> stompRealtimeReqDtoList =  listOperations.range("realtime_matchingRoom:" + roomId + "memberId:" + myMemberId, 0, -1);
            for (Object o: stompRealtimeReqDtoList) {
                StompRealtimeReqDto s = objectMapper.readValue((String) o, StompRealtimeReqDto.class);
                list.add(s);
                Long memberId = s.getMemberId();
                double lon = s.getLon();
                double lat = s.getLat();
                double distance = s.getDistance();
                int idx = s.getIdx();

                Member member = memberRepository.findById(memberId).orElseThrow(MemberNotFoundException::new);

                RealtimeRecord realtimeRecord = RealtimeRecord.builder()
                        .member(member)
                        .distance(distance)
                        .idx(idx)
                        .build();

                realtimeRecordRepository.save(realtimeRecord);

            }

        }

        // TODO 단체전(커스텀)
        else if (gameModeEnum.name().equals("CUSTOM")) {

        }

        // TODO 싱글전(연습)
        else if (gameModeEnum.name().equals("PRACTICE")) {

        }

        return list;

    }

}
