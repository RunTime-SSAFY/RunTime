package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class AchievementNotFoundException extends CustomException {

	public AchievementNotFoundException() {
		super(HttpStatus.NOT_FOUND, "존재하지 않는 도전과제입니다.");
	}
}
