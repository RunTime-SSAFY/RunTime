package org.example.back.character.service;

import org.example.back.character.dto.CharacterResponseDto;

import java.util.List;

public interface CharacterService {
    public List<CharacterResponseDto.list> characterList(Long memberId);
}
