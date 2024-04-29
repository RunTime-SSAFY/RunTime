package org.example.back.exception;

public class EmailExistsException extends RuntimeException {
	public EmailExistsException(String message) {
		super(message);
	}
}
