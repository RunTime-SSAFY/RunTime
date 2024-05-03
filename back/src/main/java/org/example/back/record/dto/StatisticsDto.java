package org.example.back.record.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StatisticsDto {
    private int countDay;
    private int calorie;
    private float distance;
    private Long duration;
}
