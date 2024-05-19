package org.example.back.stomp;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back.db.entity.Room;
import org.example.back.db.entity.RoomMember;
import org.example.back.db.repository.RoomMemberRepository;
import org.example.back.db.repository.RoomRepository;
import org.example.back.exception.RoomMemberNotFoundException;
import org.example.back.exception.RoomNotFoundException;
import org.example.back.room.service.RoomService;
import org.example.back.util.JWTUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageDeliveryException;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Component
@RequiredArgsConstructor
@Slf4j
public class StompHandler implements ChannelInterceptor {
    private final RoomMemberRepository roomMemberRepository;
    private final RoomRepository roomRepository;
//    private final RoomService roomService;
    private final RedisTemplate<String, String> redisTemplate;

    @Value("${jwt.secret}")
    private String secretKey;

    @Override
    @Transactional
    public Message<?> preSend(Message<?> message, MessageChannel channel) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);


        // websocket 연결 시 token 검증
        if ((StompCommand.CONNECT.equals(accessor.getCommand()))) {
            String authorizationHeader = accessor.getFirstNativeHeader("Authorization");

            // Authorization header에서 token 추출
            if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
                String token = authorizationHeader.substring(7);

                if (JWTUtil.validateToken(token, secretKey)) { // TODO 이 부분을 토큰의 검증으로 대체
                    log.info("socket interceptor jwt token invalid");
                    throw new MessageDeliveryException("WebSocket Interceptor: UNAUTHORIZED");
                }


                log.info("websocket interceptor: token 인증 완료");
            }

        }

        // 방을 subscribe할 때 socket의 sessionId를 roomMember에 저장한다.
        if (StompCommand.SUBSCRIBE.equals(accessor.getCommand())) {

            String authorizationHeader = accessor.getFirstNativeHeader("Authorization");
            String stringRoomId = accessor.getFirstNativeHeader("roomId");

            log.info(authorizationHeader);
            log.info(stringRoomId);

            // Authorization header에서 token 추출, roomId 추출
            if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ") && stringRoomId != null) {
                String token = authorizationHeader.substring(7);
                Long roomId = Long.parseLong(stringRoomId);
                String sessionId = accessor.getSessionId();

                JWTUtil.validateToken(token, secretKey);

                Long myMemberId = Long.parseLong(JWTUtil.getId(token, secretKey));

                RoomMember roomMember = roomMemberRepository.findByRoom_IdAndMember_Id(roomId, myMemberId).orElseThrow(() -> new RoomMemberNotFoundException(roomId, myMemberId));
                roomMember.setSessionId(sessionId);

            }


        }


        else if (StompCommand.DISCONNECT.equals(accessor.getCommand())) {
            String sessionId = accessor.getSessionId();

            List<RoomMember> roomMembers = roomMemberRepository.findBySessionId(sessionId);
            if (!roomMembers.isEmpty()) {
                RoomMember roomMember = roomMembers.get(0);
                roomMemberRepository.delete(roomMember);

                Long roomId = roomMember.getRoom().getId();
                Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(roomId));

                if (room.getRoomMembers().isEmpty()) {
                    roomRepository.delete(room);
                    redisTemplate.delete("uuid_roomId:" + roomId); // uuid 삭제
                    redisTemplate.delete("ranking_roomId:" + roomId); // 방의 인원들의 등수를 담은 데이터를 삭제한다.
                }


            }

        }

        return message;

    }
}
