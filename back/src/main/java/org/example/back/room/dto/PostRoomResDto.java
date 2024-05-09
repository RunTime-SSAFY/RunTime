package org.example.back.room.dto;

import lombok.*;

import java.util.UUID;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostRoomResDto {
    private Long roomId; // 방의 id

    private String name; // 방의 이름

    private int capacity; // 정원

    private double distance; // 목표 거리

    private String status; // 방의 상태: 대기 중인지, 게임 진행 중인지

    private String password; // 방의 비밀번호: 비밀번호가 없는 경우는 null

    @Setter
    private UUID uuid; // stomp 통신을 위한 uuid

}
