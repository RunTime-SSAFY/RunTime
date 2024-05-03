package org.example.back.result.dto;

import java.time.LocalTime;

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
public class ResultResDto {
	private Long id;
	private Long memberId;
	private Integer type;
	private Integer ranking;
	private Float distance;
	private LocalTime duration;
	private Float avgSpeed;
	private LocalTime pace;
	private Integer calorie;
}
