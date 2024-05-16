package org.example.back.realtime_record.dto;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class StompRealtimeReqDto {
    private String nickname;
    private double lon; // 경도
    private double lat; // 위도

    @Setter
    private double distance; // 총 이동거리

    @Setter
    private int idx;
    private Long roomId; // 방의 id
    private boolean reenter; // 재입장 여부
}
