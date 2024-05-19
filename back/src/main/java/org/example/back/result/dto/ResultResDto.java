package org.example.back.result.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ResultResDto {
	private Long id;
	private Integer beforeScore;
	private Integer afterScore;
	private Integer status;  // 승격 여부: -1, 0, 1
	private Integer consecutive;
}
