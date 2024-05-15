package org.example.back.stomp;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back.util.JWTUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageDeliveryException;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
@Slf4j
public class StompHandler implements ChannelInterceptor {

    @Value("${jwt.secret}")
    private String secretKey;

    @Override
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

        return message;

    }
}
