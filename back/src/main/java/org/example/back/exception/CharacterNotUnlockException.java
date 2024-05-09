package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class CharacterNotUnlockException extends CustomException {
	public CharacterNotUnlockException() { super(HttpStatus.BAD_REQUEST, "해금되지 않은 캐릭터입니다.");}
}
