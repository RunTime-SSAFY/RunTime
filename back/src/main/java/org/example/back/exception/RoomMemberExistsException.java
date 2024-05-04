package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class RoomMemberExistsException extends CustomException {
    public RoomMemberExistsException(HttpStatus httpStatus, String message) {
        super(httpStatus, message);
    }
}
