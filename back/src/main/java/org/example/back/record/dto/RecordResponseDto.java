package org.example.back.record.dto;


import lombok.*;
import org.example.back.db.enums.GameMode;

import java.util.List;
import java.util.Map;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecordResponseDto {
    private List<CoordinateDto> coordinates;
    private Long recordId;
    private Long runStartTime;
    private Long runEndTime;
    private GameMode gameMode;
    private int ranking;
    private float distance;
    private int averagePce;
    private int calorie;
}
