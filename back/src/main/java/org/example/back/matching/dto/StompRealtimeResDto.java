package org.example.back.matching.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StompRealtimeResDto {
    private String action; // realtime으로 고정
    private RealtimeDto data;
}
