package org.example.back.member.service;

import org.example.back.member.dto.ProfileResponseDto;
import org.example.back.member.dto.ProfileUpdateRequestDto;

public interface MemberService {
	ProfileResponseDto findById();

	ProfileResponseDto updateProfile(ProfileUpdateRequestDto profileUpdateRequestDto);
}
