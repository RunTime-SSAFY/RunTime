package org.example.back.character.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.example.back.character.dto.CharacterListResDto;
import org.example.back.character.service.CharacterService;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/characters")
@RequiredArgsConstructor
@Slf4j
public class CharacterController {

    private final CharacterService characterService;

    @GetMapping
    public ResponseEntity<CharacterListResDto>
    getCharacterList(@PageableDefault(size = 9) Pageable pageable  // 페이지 기본값
    ) {
        // TODO 멤버 정보 받아서 캐릭터 리스트 전부 가져옴 -> 열린 캐릭터, 안 열린 캐릭터 구분
        CharacterListResDto characterListResDto = characterService.getCharacterList(pageable);
        return ResponseEntity.ok(characterListResDto);
    }
}
