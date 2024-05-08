package org.example.back.character.service;

import org.example.back.character.dto.CharacterListResDto;
import org.example.back.character.dto.CharacterResDto;
import org.example.back.character.dto.CharacterSetResDto;
import org.example.back.db.entity.Character;
import org.example.back.db.entity.Member;
import org.example.back.db.repository.CharacterRepository;
import org.example.back.db.repository.MemberRepository;
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
    private final MemberRepository memberRepository;

    private Member getMember() {  // 현재 사용 유저의 id 조회
        // TODO 코드 작동 제대로 안 하는 것 원인 파악 후, 수정해야 함
        Long id = SecurityUtil.getCurrentMemberId();
        System.out.println(memberRepository.findAll().stream().toList());
        return memberRepository.findById(id).orElseThrow(MemberNotFoundException::new);
    }

    public CharacterListResDto getCharacterList(Pageable page){
        Long memberId = getMember().getId();
        Page<CharacterResDto> characterPage = characterRepository.findAll(memberId, page);  // 페이지 엔티티 조회
        return new CharacterListResDto(
            characterPage.stream().toList(),
            characterPage.isLast()
        );
    }

    public CharacterResDto getCharacter(Long id) {
        Long memberId = getMember().getId();
        return characterRepository.findById(id, memberId);
    }

    public CharacterSetResDto setCharacter(Long id) {
        // TODO 키 값 변경 안 되는 문제 수정해야 함
        Member member = getMember();
        CharacterResDto characterResDto = characterRepository.findById(id, member.getId());
        CharacterSetResDto characterSetResDto = new CharacterSetResDto();
        characterSetResDto.setBefore(member.getCharacter().getId());

        if(characterResDto.getUnlockStatus()) {
            member.updateCharacter(id);
            characterSetResDto.setAfter(member.getCharacter().getId());
            memberRepository.save(member);
        }
        else {
            System.out.println("추후 에러 처리");
        }
        return characterSetResDto;
    }
}
