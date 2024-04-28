package org.example.back.member.service;

import org.example.back.db.entity.Member;
import org.example.back.db.repository.MemberRepository;
import org.example.back.exception.EmailExistsException;
import org.example.back.member.dto.request.LoginDto;
import org.example.back.util.JWTUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {

	private final MemberRepository memberRepository;

	@Value("${jwt.secret}")
	private String secretKey;

	@Value("${jwt.expiration_time}")
	private Long expiredMs;

	public String login(LoginDto loginDto){

		Boolean isExist = memberRepository.existsByEmail(loginDto.getEmail());

		if(!isExist){
 			throw new EmailExistsException("이미 가입된 유저입니다.");
		}

		return JWTUtil.createJwt(loginDto.getEmail(), secretKey, expiredMs);
	}
}
