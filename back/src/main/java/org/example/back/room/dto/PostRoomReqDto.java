package org.example.back.room.dto;

import lombok.Getter;

@Getter
public class PostRoomReqDto {

    private String name; // 방의 이름
    private int capacity; // 정원
    private double distance; // 목표 거리
    private String password; // 방의 비밀번호: 비밀번호가 없는 경우는 null
}
