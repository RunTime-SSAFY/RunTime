package org.example.back.record.dto;

import org.apache.kafka.common.metrics.Stat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StatisticDto {
    private Integer countDay;
    private Integer calorie;
    private Float distance;
    private Long duration;
    private Integer year;
    private Integer month;

    public StatisticDto(Integer countDay, Integer calorie, Float distance, Long duration) {
        this.countDay = countDay;
        this.calorie = calorie;
        this.distance = distance;
        this.duration = duration;
    }
}
