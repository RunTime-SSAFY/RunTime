package org.example.back.matching.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back.enumclass.Status;
import org.example.back.matching.dto.MatchingResDto;
import org.example.back.redis.entity.MatchingRoom;
import org.example.back.redis.repository.MatchingRoomRepository;
import org.example.back.util.SecurityUtil;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

@Service
@RequiredArgsConstructor
@Slf4j
public class MatchingService {
    private final RedisTemplate<String, String> redisTemplate;
    private final MatchingRoomRepository matchingRoomRepository;
    private final SimpMessagingTemplate messagingTemplate;
    private final ObjectMapper objectMapper;
    private final SecurityUtil securityUtil;

    public void match() throws JsonProcessingException { // 매칭 대기열에 나를 추가한다
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        redisTemplate.opsForZSet().add("matching", String.valueOf(myMemberId), System.currentTimeMillis());

        Long testId= 2L;
        redisTemplate.opsForZSet().add("matching", String.valueOf(testId), System.currentTimeMillis());

        // matching sorted set의 크기가 2이상일 때, 맨 앞 두명을 매칭시킨다
        Long waitingNum = redisTemplate.opsForZSet().zCard("matching");
        if (waitingNum >= 2) {

            String[] usersId = new String[2];

            Set<String> range = redisTemplate.opsForZSet().range("matching",0, 1);
            Iterator<String> iterator = range.iterator();

            int idx = 0;
            while (iterator.hasNext()) {
                String next = iterator.next();
                redisTemplate.opsForZSet().remove("matching", next);
                usersId[idx] = next;
                idx++;
            }

            // toMatchUsers들에게 matching이 성사되었다고 알려준다.
            MatchingRoom matchingRoom = MatchingRoom.builder()
                    .users(range)
                    .status(Status.WAITING)
                    .build();

            MatchingRoom savedMatchingRoom = matchingRoomRepository.save(matchingRoom); // 매칭룸을 생성한다

            MatchingResDto firstMatchingResDto = MatchingResDto.builder()
                    .matchingRoomId(savedMatchingRoom.getId())
                    .opponentId(Long.parseLong(usersId[1]))
                    .build();

            MatchingResDto secondMatchingResDto = MatchingResDto.builder()
                    .matchingRoomId(savedMatchingRoom.getId())
                    .opponentId(Long.parseLong(usersId[0]))
                    .build();

//            String firstMatchingResDtoJson = objectMapper.writeValueAsString(firstMatchingResDto);
//            String secondMatchingResDtoJson = objectMapper.writeValueAsString(secondMatchingResDto);

            messagingTemplate.convertAndSend("/user/private/" + usersId[0], firstMatchingResDto);
            messagingTemplate.convertAndSend("/user/private/" + usersId[1], secondMatchingResDto);

        }

    }

    public void matchCancel() { // 매칭 대기열에서 나를 제외한다
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        redisTemplate.opsForZSet().remove("matching", String.valueOf(myMemberId));

    }

    public void approve(Long matchingRoomId) {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        // 매칭룸을 redis에서 찾는다
        MatchingRoom matchingRoom = matchingRoomRepository.findById(matchingRoomId).orElseThrow(() -> new RuntimeException("해당 id를 지닌 matchingRoom이 존재하지 않습니다"));
        // approved에서 나의 id를 추가한다
        if (matchingRoom.getApproved() == null) {
            Set<String> approved = new HashSet<>();
            approved.add(String.valueOf(myMemberId));
            matchingRoom.setApproved(approved);
        }

        else {
            matchingRoom.getApproved().add(String.valueOf(myMemberId));
        }

        matchingRoomRepository.save(matchingRoom);

        // approved의 개수가 2인 경우
        if (matchingRoom.getApproved().size() == 2) {
            matchingRoom.setStatus(Status.IN_PROGRESS);

            // matchingRoom의 두 유저들에게 게임이 시작되었음을 알려준다
            for (String userId: matchingRoom.getUsers()) {
                messagingTemplate.convertAndSend("/user/private/" + userId, "매칭된 상대와 게임이 시작되었습니다");
            }

        }

    }

    public void approveCancel(Long matchingRoomId) {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        // 매칭룸을 redis에서 찾는다
        MatchingRoom matchingRoom = matchingRoomRepository.findById(matchingRoomId).orElseThrow(() -> new RuntimeException("해당 id를 지닌 matchingRoom이 존재하지 않습니다"));
        // approved에서 나의 아이디를 제거한다
        if (matchingRoom.getApproved() != null) {
            matchingRoom.getApproved().remove(String.valueOf(myMemberId));
        }
        matchingRoomRepository.save(matchingRoom);

    }


}
