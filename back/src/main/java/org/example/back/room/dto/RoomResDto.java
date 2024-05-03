package org.example.back.room.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomResDto {

    private Long roomId; // 방의 id

    private String name; // 방의 제목

    private int capacity; // 정원

    private double distance; // 목표 거리

    private String status; // 방의 상태: 대기 중인지, 게임 진행 중인지


}
