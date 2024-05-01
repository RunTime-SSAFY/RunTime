package org.example.back.ranking.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@AllArgsConstructor
@ToString
public class RankerDto {
	private String nickname;
	private int tierScore;
	private String tierName;
	private String tierImage;
}
