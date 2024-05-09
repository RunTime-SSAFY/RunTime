package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class FriendAlreadyExistException extends CustomException {

	public FriendAlreadyExistException(){
		super(HttpStatus.CONFLICT, "이미 요청된 사용자입니다.");
	}
}
