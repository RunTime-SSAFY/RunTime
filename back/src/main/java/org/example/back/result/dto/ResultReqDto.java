package org.example.back.result.dto;

import java.time.LocalDateTime;
import java.time.LocalTime;

import org.example.back.db.enums.GameMode;

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
public class ResultReqDto {
	private Long memberId;
	private GameMode gameMode;
	private Integer ranking;
	private Float distance;
	private LocalDateTime runStartTime;
	private LocalDateTime runEndTime;
	private Integer duration;
	private Float avgSpeed;
	private Integer pace;
	private Integer calorie;
}
