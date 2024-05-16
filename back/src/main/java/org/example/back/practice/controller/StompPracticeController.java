package org.example.back.practice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.example.back.realtime_record.dto.RealtimeDto;
import org.example.back.realtime_record.dto.StompRealtimeReqDto;
import org.example.back.realtime_record.dto.StompRealtimeResDto;
import org.example.back.util.SecurityUtil;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
public class StompPracticeController {
    private final RedisTemplate<String, String> redisTemplate;
    private final ObjectMapper objectMapper;

    @MessageMapping("/practice")
    public void broadcast(StompRealtimeReqDto stompRealtimeReqDto) throws JsonProcessingException {
        int idx = stompRealtimeReqDto.getIdx();
        double distance = stompRealtimeReqDto.getDistance();
        boolean reenter = stompRealtimeReqDto.isReenter();

        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        // 재접속이라면 idx와 distance에 각각 lastIdx, lastDistance를 추가한다.
        if (reenter) {
            int lastIdx = Integer.parseInt(redisTemplate.opsForValue().get("lastIdx_memberId:" + myMemberId));
            double lastDistance = Double.parseDouble(redisTemplate.opsForValue().get("lastDistance_memberId:" + myMemberId));

            idx += lastIdx;
            distance += lastDistance;

        }

        stompRealtimeReqDto.setIdx(idx);
        stompRealtimeReqDto.setDistance(distance);

        ListOperations<String, String> listOperations = redisTemplate.opsForList();
        listOperations.rightPush("realtime_practice_" + "memberId:" + myMemberId, objectMapper.writeValueAsString(stompRealtimeReqDto));

    }
}
