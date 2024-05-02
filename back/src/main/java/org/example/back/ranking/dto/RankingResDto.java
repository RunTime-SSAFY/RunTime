package org.example.back.ranking.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class RankingResDto {
	private List<RankerResDto> ranking;
}
