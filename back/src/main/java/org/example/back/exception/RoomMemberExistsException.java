package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class RoomMemberExistsException extends CustomException {
    public RoomMemberExistsException(Long roomId, Long memberId) {
        super(HttpStatus.CONFLICT, roomId + "를 방 id로, " + memberId +"를 memberId로 지닌 roomMember가 존재합니다");
    }
}
