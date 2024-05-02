package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class MemberNotFoundException extends CustomException{
	public MemberNotFoundException() {
		super(HttpStatus.NOT_FOUND, "존재하지 않는 회원입니다");
	}
}
