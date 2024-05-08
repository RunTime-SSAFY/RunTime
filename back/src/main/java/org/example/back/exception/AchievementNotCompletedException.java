package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class AchievementNotCompletedException extends CustomException {

	public AchievementNotCompletedException(){
		super(HttpStatus.FORBIDDEN, "완료되지 않은 도전과제입니다.");
	}
}
