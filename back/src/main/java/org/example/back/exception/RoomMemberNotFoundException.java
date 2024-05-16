package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class RoomMemberNotFoundException extends CustomException {
    public RoomMemberNotFoundException(Long roomId, Long memberId) {

        super(HttpStatus.NOT_FOUND, memberId + "멤버가 " + roomId + "단체전 방에 입장한 상태가 아닙니다");
    }
}
