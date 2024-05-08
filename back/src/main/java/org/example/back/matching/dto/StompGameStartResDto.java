package org.example.back.matching.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StompGameStartResDto {
    private String action = "start"; // 항상 start
    private boolean data; // 매칭전 게임이 시작된다면 true, 그렇지 않다면 false
}
