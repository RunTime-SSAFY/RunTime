package org.example.back.matching.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back.matching.dto.RealtimeDto;
import org.example.back.matching.dto.StompRealtimeReqDto;
import org.example.back.matching.dto.StompRealtimeResDto;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
@Slf4j
public class StompMatchingController {
    private final SimpMessagingTemplate messagingTemplate;
    private final RedisTemplate<String, Object> redisTemplate;
    private final ObjectMapper objectMapper;
    @MessageMapping("/matchingRoom/{matchingRoomId}")
    public void broadcast(@DestinationVariable("matchingRoomId") Long matchingRoomId, StompRealtimeReqDto stompRealTimeReqDto) throws JsonProcessingException {
        // 변수 정의
        Long memberId = stompRealTimeReqDto.getMemberId();
        double lon = stompRealTimeReqDto.getLon();
        double lat = stompRealTimeReqDto.getLat();
        double distance = stompRealTimeReqDto.getDistance();
        int index = stompRealTimeReqDto.getIndex();

        // redis에 저장
        ListOperations<String, Object> listOperations = redisTemplate.opsForList();
        listOperations.rightPush("realtime_matchingRoom:" + matchingRoomId + "memberId:" + memberId, objectMapper.writeValueAsString(stompRealTimeReqDto));

//        List<Object> stompRealtimeReqDtoList =  listOperations.range("matchingRoom:" + matchingRoomId + ":" + memberId, 0, -1);
//        for (Object o: stompRealtimeReqDtoList) {
//            StompRealtimeReqDto s = objectMapper.readValue((String) o, StompRealtimeReqDto.class);
//            log.info(s.toString());
//        }

        // stomp로 보내준다
        RealtimeDto dataDto = RealtimeDto.builder().memberId(memberId).lon(lon).lat(lat).distance(distance).index(index).currentTime(LocalDateTime.now()).build();
        StompRealtimeResDto stompRealtimeResDto = StompRealtimeResDto.builder().action("realtime").data(dataDto).build();
        messagingTemplate.convertAndSend("/topic/matchingRoom/" + matchingRoomId, stompRealtimeResDto);

    }
}
