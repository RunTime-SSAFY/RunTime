package org.example.back.member.controller;

import org.example.back.util.SecurityUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/members")
@RequiredArgsConstructor
public class MemberController {


	private final SecurityUtil securityUtil;
	@GetMapping("/")
	public ResponseEntity<?> getProfile(){
		System.out.println("??");
		System.out.println("member: "+SecurityUtil.getCurrentMemberId());
		return null;
	}
}
