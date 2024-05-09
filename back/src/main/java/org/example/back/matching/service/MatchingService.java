package org.example.back.matching.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back.db.entity.Member;
import org.example.back.db.enums.Status;
import org.example.back.db.repository.MemberRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.matching.dto.OpponentResDto;
import org.example.back.matching.dto.StompGameExitResDto;
import org.example.back.matching.dto.StompGameStartResDto;
import org.example.back.matching.dto.StompMatchingSuccessResDto;
import org.example.back.redis.entity.MatchingRoom;
import org.example.back.redis.repository.MatchingRoomRepository;
import org.example.back.util.SecurityUtil;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class MatchingService {
    private final RedisTemplate<String, String> redisTemplate;
    private final MatchingRoomRepository matchingRoomRepository;
    private final MemberRepository memberRepository;
    private final SimpMessagingTemplate messagingTemplate;

    public void match() { // 매칭 대기열에 나를 추가한다
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        redisTemplate.opsForZSet().add("matching", String.valueOf(myMemberId), System.currentTimeMillis());

        // matching sorted set의 크기가 2이상일 때, 맨 앞 두명을 매칭시킨다
        Long waitingNum = redisTemplate.opsForZSet().zCard("matching");
        if (waitingNum >= 2) {

            String[] membersId = new String[2];

            log.info(Arrays.toString(membersId));

            Set<String> range = redisTemplate.opsForZSet().range("matching",0, 1);
            Iterator<String> iterator = range.iterator();

            int idx = 0;
            while (iterator.hasNext()) {
                String next = iterator.next();
                redisTemplate.opsForZSet().remove("matching", next);
                membersId[idx] = next;
                idx++;
            }

            // toMatchUsers들에게 matching이 성사되었다고 알려준다.
            MatchingRoom matchingRoom = MatchingRoom.builder()
                    .members(range)
                    .status(Status.WAITING)
                    .build();

            MatchingRoom savedMatchingRoom = matchingRoomRepository.save(matchingRoom); // 매칭룸을 생성한다

            UUID uuid = UUID.randomUUID(); // 방의 stomp 연결을 위한 랜덤 스트링
            redisTemplate.opsForValue().set("uuid_matchingRoomId:" + savedMatchingRoom.getId(), uuid.toString()) ; // uuid 저장

            Member secondMember = memberRepository.findById(Long.parseLong(membersId[1])).orElseThrow(MemberNotFoundException::new);
            OpponentResDto firstOpponentResDto = OpponentResDto.builder()
                    .matchingRoomId(matchingRoom.getId())
                    .uuid(uuid)
                    .memberId(Long.parseLong(membersId[1]))
                    .nickname(secondMember.getNickname())
                    .characterImgUrl(secondMember.getCharacter().getImgUrl()) // TODO 추후 주석 해제
                    .build();

            StompMatchingSuccessResDto firstStompMatchingSuccessResDto = StompMatchingSuccessResDto.builder()
                    .action("matching")
                    .data(firstOpponentResDto)
                    .build();

            Member firstMember = memberRepository.findById(Long.parseLong(membersId[0])).orElseThrow(MemberNotFoundException::new);

            OpponentResDto secondOpponentResDto = OpponentResDto.builder()
                    .matchingRoomId(matchingRoom.getId())
                    .uuid(uuid)
                    .memberId(Long.parseLong(membersId[0]))
                    .nickname(firstMember.getNickname())
                    .characterImgUrl(firstMember.getCharacter().getImgUrl()) // TODO 추후 주석 해제
                    .build();
            StompMatchingSuccessResDto secondStompMatchingSuccessResDto = StompMatchingSuccessResDto.builder()
                    .data(secondOpponentResDto)
                    .action("matching")
                    .build();

//            String firstMatchingResDtoJson = objectMapper.writeValueAsString(firstMatchingResDto);
//            String secondMatchingResDtoJson = objectMapper.writeValueAsString(secondMatchingResDto);

            messagingTemplate.convertAndSend("/queue/member/" + firstMember.getNickname(), firstStompMatchingSuccessResDto);
            log.info(firstMember.getNickname());
            messagingTemplate.convertAndSend("/queue/member/" + secondMember.getNickname(), secondStompMatchingSuccessResDto);
            log.info(secondMember.getNickname());
        }

    }

    public void matchCancel() { // 매칭 대기열에서 나를 제외한다
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        redisTemplate.opsForZSet().remove("matching", String.valueOf(myMemberId));

    }

    public void ready(Long matchingRoomId, boolean ready) {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        // 매칭룸을 redis에서 찾는다
        MatchingRoom matchingRoom = matchingRoomRepository.findById(matchingRoomId).orElseThrow(() -> new RuntimeException("해당 id를 지닌 matchingRoom이 존재하지 않습니다"));
        // 매칭룸에 연관된 uuid 가져온다
        String uuid = redisTemplate.opsForValue().get("uuid_matchingRoomId:" + matchingRoomId);
        // 한 명이라도 동의하지 않으면, 매칭방은 삭제되고 게임이 시작될 수 없음을 알려준다.
        if (!ready) {
            matchingRoomRepository.deleteById(matchingRoomId);
            StompGameStartResDto stompGameStartResDto = StompGameStartResDto.builder().action("start").data(false).build();
            messagingTemplate.convertAndSend("/topic/matchingRoom/" + uuid, stompGameStartResDto);
            return;
        }

        // readyMembers에서 나의 id를 추가한다.

        if (matchingRoom.getReadyMembers() == null) {
                Set<String> readyMembers = new HashSet<>();
                readyMembers.add(String.valueOf(myMemberId));
                matchingRoom.setReadyMembers(readyMembers);
        }

        else {
                matchingRoom.getReadyMembers().add(String.valueOf(myMemberId));
        }

        matchingRoomRepository.save(matchingRoom);

        // approved의 개수가 2인 경우
        if (matchingRoom.getReadyMembers().size() == 2) {
            matchingRoom.setStatus(Status.IN_PROGRESS);

            String[] membersId = new String[2];

            Set<String> membersSet = matchingRoom.getMembers();
            Iterator<String> iterator = membersSet.iterator();

            int idx = 0;
            while (iterator.hasNext()) {
                String next = iterator.next();
                membersId[idx] = next;
                idx++;
            }

            StompGameStartResDto stompGameStartResDto = StompGameStartResDto.builder()
                    .action("start")
                    .data(true)
                    .build();

            // matchingRoom의 두 유저들에게 게임이 시작되었음을 알려준다
            messagingTemplate.convertAndSend("/topic/matchingRoom/" + uuid, stompGameStartResDto);

        }

    }

    public void exit(Long matchingRoomId) {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        // 매칭룸을 redis에서 찾는다
        MatchingRoom matchingRoom = matchingRoomRepository.findById(matchingRoomId).orElseThrow(() -> new RuntimeException("해당 id를 지닌 matchingRoom이 존재하지 않습니다"));

        // uuid 가져온다
        String uuid = redisTemplate.opsForValue().get("uuid_matchingRoomId:" + matchingRoomId);

        // approved 및 members에서 String.valueOf(myMemberId) 제거
        if (matchingRoom.getReadyMembers() != null) {
            matchingRoom.getReadyMembers().remove(String.valueOf(myMemberId));
        }
        matchingRoom.getMembers().remove(String.valueOf(myMemberId));

        //Iterator<String> iterator = matchingRoom.getMembers().iterator();
        //String opponentId = iterator.next();
        //OpponentResDto opponentResDto = OpponentResDto.builder().opponentId(Long.parseLong(opponentId)).build();

        // matchingRoom update
        matchingRoomRepository.save(matchingRoom);

        StompGameExitResDto stompGameExitResDto = StompGameExitResDto.builder()
                .action("exit").build();

        messagingTemplate.convertAndSend("/topic/matchingRoom/" + uuid, stompGameExitResDto);

    }

}
