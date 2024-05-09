package org.example.back.auth.controller;

import org.example.back.auth.dto.JoinResponseDto;
import org.example.back.auth.dto.LoginDto;
import org.example.back.auth.dto.TokenResponseDto;
import org.example.back.auth.service.AuthService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("api/auth")
@RequiredArgsConstructor
public class AuthController {
	private final AuthService authService;
	@PostMapping("/login")
	public ResponseEntity<TokenResponseDto> login(@RequestBody LoginDto loginDto){

		TokenResponseDto token = authService.login(loginDto);
		return ResponseEntity.ok(token);
	}

	@PostMapping("/reissue")
	public ResponseEntity<TokenResponseDto> reissue(@RequestHeader(name = "refreshToken") String refreshToken) {
		TokenResponseDto tokenResponseDto = authService.reissueToken(refreshToken);
		return ResponseEntity.status(HttpStatus.CREATED).body(tokenResponseDto);
	}

}
