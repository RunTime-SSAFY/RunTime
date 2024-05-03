package org.example.back.record.dto;

import lombok.*;
import org.example.back.db.enums.GameMode;

@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class RecordDto {
    private Long id;
    // runStartTime

    // runEndTime
    private Long duration; // Duration 객체를 milli seconds 로 변환
    private GameMode gameMode;
    private Integer ranking;
    private Float distance;
}
