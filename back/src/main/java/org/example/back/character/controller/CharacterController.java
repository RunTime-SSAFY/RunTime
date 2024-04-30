package org.example.back.character.controller;

import lombok.RequiredArgsConstructor;
import org.example.back.character.dto.CharacterResponseDto;
import org.example.back.character.service.CharacterService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/characters")
@RequiredArgsConstructor
public class CharacterController {

    private final CharacterService characterService;

    @GetMapping
    public ResponseEntity<CharacterResponseDto> getCharacter(){

        return ResponseEntity.ok(characterService.findAll());
    }



}
