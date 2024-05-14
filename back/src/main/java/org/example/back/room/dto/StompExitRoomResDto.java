package org.example.back.room.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StompExitRoomResDto {
    private final String action = "exit"; // 항상 exit
    private String nickname; // 나간 유저의 닉네임
}
