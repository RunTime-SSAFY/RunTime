package org.example.back.member.controller;

import org.example.back.member.dto.ProfileResponseDto;
import org.example.back.member.dto.ProfileUpdateRequestDto;
import org.example.back.member.service.MemberService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/members")
@RequiredArgsConstructor
public class MemberController {

	private final MemberService memberService;

	@GetMapping
	public ResponseEntity<ProfileResponseDto> getProfile(){

		return ResponseEntity.ok(memberService.findById());
	}

	@PatchMapping
	public ResponseEntity<ProfileResponseDto> updateProfile(@RequestBody ProfileUpdateRequestDto profileUpdateRequestDto){
		return ResponseEntity.ok(memberService.updateProfile(profileUpdateRequestDto));
	}


}
