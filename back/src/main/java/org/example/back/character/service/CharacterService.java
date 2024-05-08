package org.example.back.character.service;

import org.example.back.character.dto.CharacterListResDto;
import org.example.back.character.dto.CharacterResDto;
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
        Long id = SecurityUtil.getCurrentMemberId();
        Page<CharacterResDto> characterPage = characterRepository.findAll(id, page);  // 페이지 엔티티 조회
        return new CharacterListResDto(
            characterPage.stream().toList(),
            characterPage.isLast()
        );
    }
}
