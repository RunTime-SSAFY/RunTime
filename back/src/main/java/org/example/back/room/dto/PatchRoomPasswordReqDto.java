package org.example.back.room.dto;

import lombok.Getter;

@Getter
public class PatchRoomPasswordReqDto {
    private Long roomId;
    private String password;
}
