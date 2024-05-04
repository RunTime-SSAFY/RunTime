package org.example.back.matching.controller;

import lombok.RequiredArgsConstructor;
import org.example.back.matching.dto.MatchingResDto;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class WebSocketTestController {
    private final SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/test/{id}")
    public void testWebSocket(@DestinationVariable("id") Long id) {
        MatchingResDto firstMatchingResDto = MatchingResDto.builder()
                .matchingRoomId(id)
                .opponentId(id)
                .build();

        messagingTemplate.convertAndSend("queue/member/private/"+id,  firstMatchingResDto);

    }
}
