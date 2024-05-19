package org.example.back.character.service;

import java.util.List;

import org.example.back.character.dto.CharacterListResDto;
import org.example.back.character.dto.CharacterResDto;
import org.example.back.character.dto.CharacterSetResDto;
import org.example.back.db.entity.Character;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.UnlockedCharacter;
import org.example.back.db.entity.UnlockedCharacterId;
import org.example.back.db.repository.CharacterRepository;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.UnlockedCharacterRepository;
import org.example.back.exception.CharacterNotFoundException;
import org.example.back.exception.CharacterNotUnlockException;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CharacterService {

	private final CharacterRepository characterRepository;
	private final UnlockedCharacterRepository unlockedCharacterRepository;
	private final MemberRepository memberRepository;

	private Member getMember() {  // 현재 사용 유저의 id 조회
		Long id = SecurityUtil.getCurrentMemberId();
		return memberRepository.findById(id).orElseThrow(MemberNotFoundException::new);
	}

	public List<CharacterResDto> getCharacterList() {
		Long memberId = getMember().getId();
		List<CharacterResDto> list = characterRepository.findAll(memberId);

		Long mainCharacterId = getMember().getCharacter().getId();

		for (CharacterResDto characterResDto : list) {
			if(characterResDto.getId().equals(mainCharacterId)){
				characterResDto.setIsMain(true);
			}
		}
		return list;  // 페이지 엔티티 조회

	}

	public CharacterResDto getCharacter(Long id) {
		Long memberId = getMember().getId();
		CharacterResDto characterResDto = characterRepository.findByCharacterIdAndMemberId(id, memberId);

		if (characterResDto.getUnlockStatus() && !characterResDto.getIsCheck())
			characterResDto.setIsCheck(true);

		UnlockedCharacterId unlockedCharacterId = UnlockedCharacterId.builder()  // 캐릭터 생성
			.characterId(id)
			.memberId(memberId)
			.build();

		unlockedCharacterRepository.save(UnlockedCharacter.builder()
			.id(unlockedCharacterId)
			.isCheck(characterResDto.getIsCheck())
			.build()
		);

		return characterResDto;
	}

	public CharacterSetResDto setCharacter(Long id) throws CharacterNotUnlockException {
		Member member = getMember();
		Character character = characterRepository.findById(id).orElseThrow(CharacterNotFoundException::new);
		Boolean unlock = characterRepository  // 캐릭터 비활성 상태 확인
			.findByCharacterIdAndMemberId(id, member.getId())
			.getUnlockStatus();
		CharacterSetResDto characterSetResDto = new CharacterSetResDto();
		characterSetResDto.setBefore(member.getCharacter().getId());  // 변경 전, 대표 캐릭터

		if (unlock) {
			member.updateCharacter(character);
			characterSetResDto.setAfter(member.getCharacter().getId());  // 변경 후, 대표 캐릭터
			memberRepository.save(member);
		} else {
			throw new CharacterNotUnlockException();
		}

		return characterSetResDto;
	}
}
