package org.example.back.realtime_record.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class SaveRealtimeRecordReqDto {
    private Long recordId; // 기록의 id
    private Long roomId; // 게임의 방의 id
}
