package org.example.back.practice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.example.back.practice.dto.PracticeRealtimeDto;
import org.example.back.realtime_record.dto.RealtimeDto;
import org.example.back.realtime_record.dto.StompRealtimeReqDto;
import org.example.back.realtime_record.dto.StompRealtimeResDto;
import org.example.back.util.SecurityUtil;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class StompPracticeController {
    private final RedisTemplate<String, String> redisTemplate;
    private final ObjectMapper objectMapper;
    private final SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/practice/{uuid}")
    public void broadcast(@DestinationVariable String uuid, StompRealtimeReqDto stompRealtimeReqDto) throws JsonProcessingException {
        int idx = stompRealtimeReqDto.getIdx();
        double distance = stompRealtimeReqDto.getDistance();
        boolean reenter = stompRealtimeReqDto.isReenter();
        String myNickname = stompRealtimeReqDto.getNickname();

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

        // stomp로 방금 내가 보낸 정보를 보내준다
        RealtimeDto dataDto = RealtimeDto.builder().nickname(myNickname).distance(distance).idx(idx).currentTime(LocalDateTime.now()).build();
        StompRealtimeResDto stompRealtimeResDto = StompRealtimeResDto.builder().action("realtime").data(dataDto).build();
        messagingTemplate.convertAndSend("/topic/practice/" + uuid, stompRealtimeResDto);

        // stomp로 고스트의 정보를 보내준다
        List<PracticeRealtimeDto> practiceRealtimeDtos = objectMapper.readValue(redisTemplate.opsForValue().get("realtime_practice_ghost"), new TypeReference<>() {
        }) ;

        if (idx < practiceRealtimeDtos.size()) {
            PracticeRealtimeDto practiceRealtimeDto = practiceRealtimeDtos.get(idx);
            double ghostDistance = practiceRealtimeDto.getDistance();

            RealtimeDto ghostRealtimeDto = RealtimeDto.builder().nickname("ghost" + uuid).distance(ghostDistance).idx(idx).currentTime(LocalDateTime.now()).build();
            StompRealtimeResDto ghostRealtimeResDto = StompRealtimeResDto.builder().action("realtime").data(ghostRealtimeDto).build();
            messagingTemplate.convertAndSend("/topic/practice/" + uuid, ghostRealtimeResDto);

        }



    }

}
