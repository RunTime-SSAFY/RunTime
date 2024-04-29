package org.example.back.auth.controller;

import org.example.back.auth.dto.LoginDto;
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
	public ResponseEntity<String> login(@RequestBody LoginDto loginDto){

		String token = authService.login(loginDto);
		return ResponseEntity.ok(token);
	}

	@PostMapping("/join")
	public ResponseEntity<String> join() {
		return ResponseEntity.ok("dasf");
	}
}
