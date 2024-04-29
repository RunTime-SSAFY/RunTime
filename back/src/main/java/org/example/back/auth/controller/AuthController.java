package org.example.back.auth.controller;

import org.example.back.auth.dto.JoinResponseDto;
import org.example.back.auth.dto.LoginDto;
import org.example.back.auth.dto.TokenResponseDto;
import org.example.back.auth.service.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

		TokenResponseDto token = authService.login(loginDto.getEmail());
		return ResponseEntity.ok(token);
	}

	@PostMapping("/join")
	public ResponseEntity<JoinResponseDto> join(@RequestBody LoginDto loginDto) {
		return ResponseEntity.ok(authService.join(loginDto.getEmail()));
	}
}
