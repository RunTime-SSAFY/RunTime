package org.example.back.matching.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OpponentResDto {
    private Long matchingRoomId;
    private UUID uuid;
    private Long memberId;
    private String nickname;
    private String characterImgUrl;
}
