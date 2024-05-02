package org.example.back.character.service;

import org.example.back.character.dto.CharacterResponseDto;
import org.example.back.db.repository.CharacterRepository;
import org.example.back.db.repository.MemberRepository;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

public class CharacterService {

    private final CharacterRepository characterRepository;
    private final MemberRepository memberRepository;

    public CharacterResponseDto findAllList(Pageable pageable, Long memberId){
        Long id = SecurityUtil.getCurrentMemberId();
        Slice<CharacterResponseDto> result=memberRepository.findAll

    }

}
