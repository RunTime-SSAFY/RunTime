package org.example.back.auth.controller;

import org.example.back.auth.dto.*;
import org.example.back.auth.service.AuthService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("api/auth")
@RequiredArgsConstructor
public class AuthController {
	private final AuthService authService;

	@PostMapping("/login")
	public ResponseEntity<TokenResponseDto> login(@RequestBody LoginDto loginDto) {

		TokenResponseDto token = authService.login(loginDto);
		return ResponseEntity.ok(token);
	}

	@PostMapping("/reissue")
	public ResponseEntity<TokenResponseDto> reissue(@RequestHeader(name = "refreshToken") String refreshToken) {
		TokenResponseDto tokenResponseDto = authService.reissueToken(refreshToken);
		return ResponseEntity.status(HttpStatus.CREATED).body(tokenResponseDto);
	}

	@PostMapping("/logout")
	public void logout(@RequestBody TokenRequestDto tokenRequestDto) {
		authService.logout(tokenRequestDto);
	}

	@PostMapping("/join")
	public ResponseEntity<TestJoinResponseDto> join(@RequestBody TestDto testDto) {
		String email = testDto.getEmail();
		String nickname = testDto.getNickname();
		TestJoinResponseDto testJoinResponseDto = authService.join(email, nickname);

		return ResponseEntity.ok().body(testJoinResponseDto);

	}
}
