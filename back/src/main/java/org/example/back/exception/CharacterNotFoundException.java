package org.example.back.exception;

import org.example.back.common.CustomException;
import org.springframework.http.HttpStatus;

public class CharacterNotFoundException extends CustomException {

	public CharacterNotFoundException(){
		super(HttpStatus.NOT_FOUND, "존재하지 않는 캐릭터입니다.");
	}
}
