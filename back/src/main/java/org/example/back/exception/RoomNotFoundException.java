package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class RoomNotFoundException extends CustomException {
    public RoomNotFoundException(HttpStatus httpStatus, String message) {
        super(httpStatus, message);
    }
}
