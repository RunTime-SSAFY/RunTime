package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class AchievementAlreadyReceivedException extends CustomException {

	public AchievementAlreadyReceivedException(){
		super(HttpStatus.CONFLICT, "이미 완료한 도전과제입니다.");
	}
}
