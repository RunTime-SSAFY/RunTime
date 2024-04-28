package org.example.back.auth.kakao.controller;

import org.example.back.auth.kakao.service.KakaoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/auth/kakao")
@RequiredArgsConstructor
public class KakaoAuthController {

	private final KakaoService kakaoService;

	@GetMapping("/code")
	public ResponseEntity<?> kakaoAuth(@RequestParam("code") String code) {
//		String token =
		return null;
	}
}
