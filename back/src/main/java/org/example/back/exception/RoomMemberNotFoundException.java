package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class RoomMemberNotFoundException extends CustomException {
    public RoomMemberNotFoundException(HttpStatus httpStatus, String message) {
        super(httpStatus, message);
    }
}
