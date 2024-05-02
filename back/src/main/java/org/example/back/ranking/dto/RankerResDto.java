package org.example.back.ranking.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@AllArgsConstructor
@ToString
public class RankerResDto {
	private String nickname;
	private Integer tierScore;
	private String tierName;
	private String tierImage;
}
