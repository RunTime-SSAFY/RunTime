package org.example.back.member.service;

import org.example.back.db.entity.Member;
import org.example.back.db.repository.MemberRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.member.dto.ProfileResponseDto;
import org.example.back.member.dto.ProfileUpdateRequestDto;
import org.example.back.util.SecurityUtil;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberRepository memberRepository;

	@Override
	public ProfileResponseDto findById() {

		Member member = getMember();

		return ProfileResponseDto.builder()
			.nickname(member.getNickname())
			.weight(member.getWeight())
			.characterId(member.getCharacter().getId())
			.build();
	}

	@Override
	public ProfileResponseDto updateProfile(ProfileUpdateRequestDto profileUpdateRequestDto) {

		// 현재 로그인중인 유저
		Member member = getMember();

		// 입력받은 닉네임이 있으면 업데이트
		if (profileUpdateRequestDto.getNickname() != null) {
			member.updateNickname(profileUpdateRequestDto.getNickname());
		}

		//  입력받은 몸무게가 있으면 업데이트
		if (profileUpdateRequestDto.getWeight() != null) {
			member.updateWeight(profileUpdateRequestDto.getWeight());
		}

		memberRepository.save(member);

		return ProfileResponseDto.builder()
			.nickname(member.getNickname())
			.weight(member.getWeight())
			.characterId(member.getCharacter().getId())
			.build();
	}

	// security 정보에서 사용자 정보 가져오기
	private Member getMember() {
		Long id = SecurityUtil.getCurrentMemberId();

		Member member = memberRepository.findById(id).orElseThrow(MemberNotFoundException::new);
		return member;
	}
}
