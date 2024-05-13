package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class StatisticBadRequestException extends CustomException {
    public StatisticBadRequestException() {
        super(HttpStatus.BAD_REQUEST, "파라미터가 부족합니다.");
    }
}
