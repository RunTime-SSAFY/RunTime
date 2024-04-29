package org.example.back.auth.service;

import org.example.back.auth.dto.JoinResponseDto;
import org.example.back.auth.dto.TokenResponseDto;
import org.example.back.db.entity.Member;
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

	public TokenResponseDto login(String email){

		Boolean isExist = memberRepository.existsByEmail(email);

		if(!isExist){
 			throw new EmailExistsException("없는 유저입니다");
		}
		String accessToken = JWTUtil.createJwt(email, secretKey, expiredMs);
		String refreshToken = JWTUtil.createRefreshToken(secretKey);
		return TokenResponseDto.builder()
			.accessToken(accessToken)
			.refreshToken(refreshToken)
			.build();
	}

	public JoinResponseDto join(String email) {
		Member member = new Member();
		member.setEmail(email);
		Long id = memberRepository.save(member).getId();

		String accessToken = JWTUtil.createJwt(email, secretKey, expiredMs);
		String refreshToken = JWTUtil.createRefreshToken(secretKey);


		return JoinResponseDto.builder()
			.id(id)
			.email(email)
			.tokenResponseDto(TokenResponseDto.builder()
				.accessToken(accessToken)
				.refreshToken(refreshToken)
				.build())
			.build();

	}

	public boolean isExistMember(String email) {
		return memberRepository.existsByEmail(email);
	}
}
