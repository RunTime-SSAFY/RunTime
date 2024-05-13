package org.example.back.record.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StatisticDto {
    private int countDay;
    private int calorie;
    private float distance;
    private Long duration;
}
