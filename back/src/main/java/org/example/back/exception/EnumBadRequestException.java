package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class EnumBadRequestException extends CustomException {
    public EnumBadRequestException() {
        super(HttpStatus.BAD_REQUEST, "잘못된 Enum 타입이 요청되었습니다.");
    }
}
