package org.example.back.room.dto;

import lombok.Getter;

@Getter
public class PatchRoomDistanceReqDto {
    private Long roomId;
    private double distance;
}
