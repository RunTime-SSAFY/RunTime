package org.example.back.character.service;

import lombok.RequiredArgsConstructor;
import org.example.back.character.dto.CharacterResponseDto;
import org.example.back.db.repository.CharacterRepository;
import org.example.back.util.SecurityUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CharacterServiceImpl implements CharacterService {

    private final CharacterRepository characterRepository;


    @Transactional
    @Override



    public List<CharacterResponseDto.list> characterList(Long memberId){
        Long id = SecurityUtil.getCurrentMemberId();

        List<Character> characterList=
        return null;
    }
}
