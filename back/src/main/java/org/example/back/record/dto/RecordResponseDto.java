package org.example.back.record.dto;


import lombok.*;
import org.example.back.db.enums.GameMode;

import java.time.LocalDateTime;
import java.util.List;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecordResponseDto {
    private String courseImgUrl;
    private Long recordId;
    private LocalDateTime runStartTime;
    private LocalDateTime runEndTime;
    private GameMode gameMode; // 알아서 String 값으로 넘어감
    private int ranking;
    private float distance;
    private int averagePace;
    private int calorie;
}
