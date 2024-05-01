package org.example.back.result.dto;

import java.time.LocalTime;

import org.example.back.db.entity.Member;

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
public class ResultDto {
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
