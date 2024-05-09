package org.example.back.record.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.back.db.enums.StatisticsType;

import java.util.List;
import java.util.Map;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StatisticsResponseDto {
    private StatisticsType type;
    private int countDay;
    private int calorie;
    private float distance;
    private Long duration;
}
