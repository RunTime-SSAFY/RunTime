package org.example.back.room.dto;

import lombok.Getter;

@Getter
public class PatchRoomCapacityReqDto {
    private Long roomId;
    private int capacity;
}
