package org.example.back.auth.service;

import org.example.back.db.repository.MemberRepository;
import org.example.back.exception.EmailExistsException;
import org.example.back.auth.dto.LoginDto;
import org.example.back.util.JWTUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {

	private final MemberRepository memberRepository;

	@Value("${jwt.secret}")
	private String secretKey;

	@Value("${jwt.expiration_time}")
	private Long expiredMs;

	public String login(LoginDto loginDto){

		Boolean isExist = memberRepository.existsByEmail(loginDto.getEmail());

		if(!isExist){
 			throw new EmailExistsException("없는 유저입니다");
		}

		return JWTUtil.createJwt(loginDto.getEmail(), secretKey, expiredMs);
	}
}
