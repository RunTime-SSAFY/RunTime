package org.example.back.character.service;

import org.example.back.character.dto.CharacterListResDto;
import org.example.back.character.dto.CharacterResDto;
import org.example.back.db.entity.Character;
import org.example.back.db.repository.CharacterRepository;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CharacterService {

    private final CharacterRepository characterRepository;

    public CharacterListResDto getCharacterList(Pageable page){
        Long memberId = SecurityUtil.getCurrentMemberId();
        Page<CharacterResDto> characterPage = characterRepository.findAll(memberId, page);  // 페이지 엔티티 조회
        return new CharacterListResDto(
            characterPage.stream().toList(),
            characterPage.isLast()
        );
    }

    public CharacterResDto getCharacter(Long id) {
        Long memberId = SecurityUtil.getCurrentMemberId();
        return characterRepository.findById(id, memberId);
    }
}
