package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class ReenterForbiddenException extends CustomException {

    public ReenterForbiddenException(Long roomId) {
        super(HttpStatus.BAD_REQUEST, roomId + "에 재입장을 할 수 없습니다");
    }
}
