package org.example.back.member.controller;

import org.example.back.member.dto.request.LoginDto;
import org.example.back.member.service.MemberService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/members")
@RequiredArgsConstructor
public class MemberController {

	private final MemberService memberService;
	@PostMapping("/login")
	public ResponseEntity<String> login(@RequestBody LoginDto loginDto){

		String token = memberService.login(loginDto);
		return ResponseEntity.ok(token);
	}

	@PostMapping("/join")
	public ResponseEntity<String> join() {
		return ResponseEntity.ok("dasf");
	}
}
