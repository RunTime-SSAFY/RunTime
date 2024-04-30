package org.example.back.character.service;

import lombok.RequiredArgsConstructor;
import org.example.back.character.dto.CharacterResponseDto;
import org.example.back.db.repository.CharacterRepository;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CharacterServiceImpl implements CharacterService {
    private final CharacterRepository characterRepository;


    @Override
    public CharacterResponseDto findAll() {
        return null;
    }
}
