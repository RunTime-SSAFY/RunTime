package org.example.back.auth.controller;

import org.example.back.auth.dto.KakaoInfoResponse;
import org.example.back.auth.service.KakaoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("api/auth/kakao")
@RequiredArgsConstructor
public class KakaoAuthController {

	private final KakaoService kakaoService;

	@GetMapping("/code")
	public ResponseEntity<?> kakaoAuth(@RequestParam("code") String code) {
		String token = kakaoService.getToken(code);
		System.out.println("token: "+token);
		KakaoInfoResponse kakaoInfoResponse = kakaoService.getKakaoInfo(token);


		System.out.println(kakaoInfoResponse.getEmail());
		return null;
	}
}
