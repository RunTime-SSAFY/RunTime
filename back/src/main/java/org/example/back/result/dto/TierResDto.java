package org.example.back.result.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TierResDto {
	private Integer beforeScore;
	private Integer afterScore;
	private Integer status;  // 승격 여부: -1, 0, 1
}
