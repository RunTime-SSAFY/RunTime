package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class RefreshTokenNotFoundException extends CustomException {
    public RefreshTokenNotFoundException() {
        super(HttpStatus.NOT_FOUND, "refresh Token을 찾을 수 없습니다.");
    }
}
