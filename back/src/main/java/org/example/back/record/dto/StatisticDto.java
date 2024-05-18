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
    private Integer countDay;
    private Integer calorie;
    private Float distance;
    private Long duration;
}
