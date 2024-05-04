package org.example.back.common;

import jakarta.servlet.http.HttpServletRequest;
import lombok.Getter;
import org.example.back.common.mattermost.NotificationManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Enumeration;

@Getter
@RestControllerAdvice
public class GlobalExceptionHandler {
    @Autowired
    private NotificationManager notificationManager;

    // CustomException 처리
    @ExceptionHandler(CustomException.class)
    public ResponseEntity<String> handleCustomException(CustomException e) {
        return new ResponseEntity<>(e.getMessage(), e.getHttpStatus());
    }

    // 위의 모든 경우에 해당하지 않는 exception
//    @ExceptionHandler(Exception.class)
//    public ResponseEntity<String> handleGlobalException(Exception e) {
//        return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
//    }



    // 전역 예외 처리
    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleGlobalException(Exception e, HttpServletRequest req) {
        e.printStackTrace();
        notificationManager.sendNotification(e, req.getRequestURI(), getParams(req));
        return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    private String getParams(HttpServletRequest req) {
        StringBuilder params = new StringBuilder();
        Enumeration<String> keys = req.getParameterNames();
        while (keys.hasMoreElements()) {
            String key = keys.nextElement();
            params.append("- ").append(key).append(" : ").append(req.getParameter(key)).append('\n');
        }
        return params.toString();
    }


}



//    200	OK	                            성공
//    201	Created	                        생성됨
//    202	Accepted	                    허용됨
//    203	Non-Authoritative Information	신뢰할 수 없는 정보
//    204	No Content	                    콘텐츠 없음
//    205	Reset Content	                콘텐츠 재설정
//    206	Partial Content	                일부 콘텐츠
//    207	Multi-Status	                다중 상태

//    400	Bad Request	                    잘못된 요청
//    401	Unauthorized	                권한 없음
//    402	Payment Required	            결제 필요
//    403	Forbidden	                    금지됨
//    404	Not Found	                    찾을 수 없음
//    405	Method Not Allowed	            허용되지 않은 메소드
//    406	Not Acceptable	                수용할 수 없음
//    407	Proxy Authentication Required	프록시 인증 필요
//    408	Request Timeout	                요청 시간초과
//    409	Conflict	                    충돌

//    500	Internal Server Error	        내부 서버 오류
//    501	Not Implemented	                구현되지 않음
//    502	Bad Gateway	                    불량 게이트웨이
//    503	Service Unavailable	            서비스 제공불가
//    504	Gateway Timeout	                게이트웨이 시간초과
//    505	HTTP Version Not Supported	    HTTP 버전 미지원

