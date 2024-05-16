package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class MatchingRoomNotFoundException extends CustomException {
    public MatchingRoomNotFoundException(Long matchingRoomId) {
        super(HttpStatus.NOT_FOUND, matchingRoomId + "를 id로 지닌 matchingRoom이 존재하지 않습니다");

    }
}
