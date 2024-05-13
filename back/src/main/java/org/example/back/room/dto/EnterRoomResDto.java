package org.example.back.room.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EnterRoomResDto {
    private Long roomMemberId;
    private UUID uuid;
    private int lastIdx;
    private double lastDistance;
    private List<MemberResDto> data;
}
