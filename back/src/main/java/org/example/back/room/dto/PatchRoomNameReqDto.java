package org.example.back.room.dto;

import lombok.Getter;

@Getter
public class PatchRoomNameReqDto {
    private Long roomId;
    private String name; // 수정할 방의 이름
}
