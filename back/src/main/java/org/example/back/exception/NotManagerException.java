package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class NotManagerException extends CustomException { // 방장이 아닌 자가 방장의 권리를 행했을 때
    public NotManagerException(HttpStatus httpStatus, String message) {
        super(httpStatus, message);
    }
}
