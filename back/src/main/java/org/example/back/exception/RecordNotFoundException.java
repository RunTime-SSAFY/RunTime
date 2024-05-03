package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class RecordNotFoundException extends CustomException {
    public RecordNotFoundException() {
        super(HttpStatus.NOT_FOUND, "기록을 찾을 수 없습니다.");
    }
}
