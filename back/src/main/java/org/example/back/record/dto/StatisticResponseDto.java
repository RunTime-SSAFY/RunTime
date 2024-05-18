package org.example.back.record.dto;

import java.util.List;

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
    private Integer countDay;
    private Integer calorie;
    private Float distance;
    private Long duration;
    private List<Integer> runDateList;
}
