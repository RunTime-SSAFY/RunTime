package org.example.back.record.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.back.db.enums.StatisticType;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StatisticResponseDto {
    private StatisticType type;
    private int countDay;
    private int calorie;
    private float distance;
    private Long duration;
}
