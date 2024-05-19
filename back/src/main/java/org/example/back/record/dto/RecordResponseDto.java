package org.example.back.record.dto;


import lombok.*;
import org.example.back.db.enums.GameMode;

import java.time.LocalDateTime;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecordResponseDto {
    private String courseImgUrl;
    private Long id;
    private LocalDateTime runStartTime;
    private LocalDateTime runEndTime;
    private GameMode gameMode; // 알아서 String 값으로 넘어감
    private int ranking;
    private float distance;
    private Long duration;
    private int averagePace;
    private int calorie;
//    private Long id;
//    // runStartTime
//    private LocalDateTime runStartTime;
//    // runEndTime
//    private Long duration; // Duration 객체를 milli seconds 로 변환
//    private GameMode gameMode;
//    private Integer ranking;
//    private Float distance;
}
