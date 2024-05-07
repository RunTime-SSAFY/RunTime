package org.example.back.achievement.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RecordSummaryResDto {

	private Float totalDistance;
	private Integer countWins;
	private Float totalDuration;

}
