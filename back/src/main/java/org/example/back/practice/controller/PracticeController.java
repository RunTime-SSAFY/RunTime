package org.example.back.practice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.back.matching.dto.MatchingRankingResDto;
import org.example.back.matching.dto.MatchingReqDto;
import org.example.back.matching.dto.ReadyReqDto;
import org.example.back.matching.service.MatchingService;
import org.example.back.practice.dto.PracticeResDto;
import org.example.back.practice.service.PracticeService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/practice")
public class PracticeController {

    private final PracticeService practiceService;

    @GetMapping("")
    public ResponseEntity<PracticeResDto> getPracticeResDto() {
        PracticeResDto practiceResDto = practiceService.getPracticeResDto();

        return ResponseEntity.ok().body(practiceResDto);
    }

}
