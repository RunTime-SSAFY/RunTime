package org.example.back.record.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StatisticsResponseDto {
    private StatisticsDto month;
    private StatisticsDto year;
    private StatisticsDto allTime;
}
