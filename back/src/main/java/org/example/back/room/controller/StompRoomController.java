package org.example.back.room.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.example.back.db.entity.Member;
import org.example.back.db.repository.MemberRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.realtime_record.dto.RealtimeDto;
import org.example.back.realtime_record.dto.StompRealtimeReqDto;
import org.example.back.realtime_record.dto.StompRealtimeResDto;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
public class StompRoomController {
    private final MemberRepository memberRepository;
    private final SimpMessagingTemplate messagingTemplate;
    private final RedisTemplate<String, Object> redisTemplate;
    private final ObjectMapper objectMapper;

    @MessageMapping("/room/{uuid}")
    public void broadcast(@DestinationVariable("uuid") String uuid, StompRealtimeReqDto stompRealtimeReqDto) throws JsonProcessingException {
        String nickname = stompRealtimeReqDto.getNickname();
        double lon = stompRealtimeReqDto.getLon();
        double lat = stompRealtimeReqDto.getLat();
        double distance = stompRealtimeReqDto.getDistance();
        int idx = stompRealtimeReqDto.getIdx();
        Long roomId = stompRealtimeReqDto.getRoomId();

        Member member = memberRepository.findByNickname(nickname).orElseThrow(MemberNotFoundException::new);
        Long memberId = member.getId();

        ListOperations<String, Object> listOperations = redisTemplate.opsForList();
        listOperations.rightPush("realtime_roomId:" + roomId + "memberId:" + memberId, objectMapper.writeValueAsString(stompRealtimeReqDto));

        // stomp로 보내준다
        RealtimeDto dataDto = RealtimeDto.builder().nickname(nickname).distance(distance).idx(idx).currentTime(LocalDateTime.now()).build();
        StompRealtimeResDto stompRealtimeResDto = StompRealtimeResDto.builder().action("realtime").data(dataDto).build();
        messagingTemplate.convertAndSend("/topic/room/" + uuid, stompRealtimeResDto);

    }

}
