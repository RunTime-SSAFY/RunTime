package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class RoomNotFoundException extends CustomException {
    public RoomNotFoundException(Long roomId) {

        super(HttpStatus.NOT_FOUND, roomId + "는 존재하지 않는 방입니다");
        ;
    }
}
