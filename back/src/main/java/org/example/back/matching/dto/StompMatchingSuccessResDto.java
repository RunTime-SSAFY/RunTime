package org.example.back.matching.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StompMatchingSuccessResDto {
    private String action; // 매칭이 성사된 경우 matching
    private OpponentResDto data;
}
