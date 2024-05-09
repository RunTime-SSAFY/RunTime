package org.example.back.auth.service;

import java.util.List;

import org.example.back.auth.dto.JoinResponseDto;
import org.example.back.auth.dto.TokenResponseDto;
import org.example.back.db.entity.AchievementType;
import org.example.back.db.entity.Character;
import org.example.back.db.entity.CurrentAchievement;
import org.example.back.db.entity.CurrentAchievementId;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.UnlockedCharacter;
import org.example.back.db.entity.UnlockedCharacterId;
import org.example.back.db.repository.AchievementTypeRepository;
import org.example.back.db.repository.CharacterRepository;
import org.example.back.db.repository.CurrentAchievementRepository;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.UnlockedCharacterRepository;
import org.example.back.exception.CharacterNotFoundException;
import org.example.back.exception.EmailExistsException;
import org.example.back.auth.dto.LoginDto;
import org.example.back.exception.RefreshTokenNotFoundException;
import org.example.back.redis.entity.RefreshToken;
import org.example.back.redis.repository.RefreshTokenRepository;
import org.example.back.util.JWTUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {

	private final MemberRepository memberRepository;
	private final CharacterRepository characterRepository;
	private final CurrentAchievementRepository currentAchievementRepository;
	private final AchievementTypeRepository achievementTypeRepository;
	private final UnlockedCharacterRepository unlockedCharacterRepository;
	private final RefreshTokenRepository refreshTokenRepository;

	@Value("${jwt.secret}")
	private String secretKey;

	@Value("${jwt.expiration_time}")
	private Long expiredMs;

	@Transactional
	public TokenResponseDto login(LoginDto loginDto){

		String email = loginDto.getEmail();
		String fcmToken = loginDto.getFcmToken();

		Member member = memberRepository.findByEmail(email);
		boolean isNewMember = false;
		// 회원이 없음 -> 회원가입.
		if(member==null){
			// 기본 캐릭터 지급
			Character defaultCharacter = characterRepository.findById(1L).orElseThrow(CharacterNotFoundException::new);

			member = Member.builder()
				.email(email)
				.character(defaultCharacter)
				.build();
			// 신규 회원 저장
			Long id = memberRepository.save(member).getId();
			// 보유 캐릭터에 기본 캐릭터 추가
			UnlockedCharacter unlockedCharacter = UnlockedCharacter.builder()
				.id(UnlockedCharacterId.builder()
					.characterId(1L)
					.memberId(id)
					.build())
				.build();
			unlockedCharacterRepository.save(unlockedCharacter);

			// 도전과제 분류별 최초 단계 추가
			List<AchievementType> achievementTypeList = achievementTypeRepository.findAll();
			for (AchievementType achievementType : achievementTypeList) {
				CurrentAchievement currentAchievement = CurrentAchievement.builder()
					.id(CurrentAchievementId.builder()
						.achievementTypeId(achievementType.getId())
						.memberId(member.getId())
						.build())
					.member(member)
					.achievementType(achievementType)
					.currentGrade(1)
					.build();
				currentAchievementRepository.save(currentAchievement);
			}
		}

		// 아직 닉네임을 설정하지 않았다면 최초 로그인.
		if(member.getNickname()==null){
			isNewMember = true;
		}
		member.updateFcmToken(fcmToken);

		memberRepository.save(member);

		String accessToken = JWTUtil.createJwt(member.getId(), secretKey, expiredMs);
		String refreshToken = JWTUtil.createRefreshToken(secretKey);

		RefreshToken redis = new RefreshToken(refreshToken, member.getId());
		refreshTokenRepository.save(redis);

		return TokenResponseDto.builder()
			.accessToken(accessToken)
			.refreshToken(refreshToken)
			.isNewMember(isNewMember)
			.build();
	}

	public JoinResponseDto join(String email) {
		Member member = Member.builder()
			.email(email)
			.build();
		Long id = memberRepository.save(member).getId();

		String accessToken = JWTUtil.createJwt(id, secretKey, expiredMs);
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

	public TokenResponseDto reissueToken(String refreshToken) {
		System.out.println(refreshToken);
		RefreshToken redisToken = refreshTokenRepository.findById(refreshToken).orElseThrow(
			RefreshTokenNotFoundException::new);
		String accessToken = JWTUtil.createJwt(redisToken.getMemberId(), secretKey, expiredMs);
		String newRefreshToken = JWTUtil.createRefreshToken(secretKey);
		RefreshToken redis = new RefreshToken(newRefreshToken, redisToken.getMemberId());
		refreshTokenRepository.save(redis);

		return TokenResponseDto.builder()
			.accessToken(accessToken)
			.refreshToken(newRefreshToken)
			.isNewMember(false)
			.build();

	}
}
