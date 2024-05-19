package org.example.back.practice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.back.practice.dto.PracticeStartResDto;
import org.example.back.practice.service.PracticeService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/practice")
public class PracticeController {

    private final PracticeService practiceService;

//    @GetMapping("")
//    public ResponseEntity<PracticeResDto> getPracticeResDto() {
//        PracticeResDto practiceResDto = practiceService.getPracticeResDto();
//
//        return ResponseEntity.ok().body(practiceResDto);
//
//    }

    @PatchMapping("/reenter")
    public ResponseEntity<PracticeStartResDto> reenter() throws JsonProcessingException {
        PracticeStartResDto practiceStartResDto = practiceService.reenter();

        return ResponseEntity.ok().body(practiceStartResDto);

    }

    @PostMapping("")
    public ResponseEntity<PracticeStartResDto> startPractice() throws JsonProcessingException {
        PracticeStartResDto practiceStartResDto = practiceService.startPractice();

        return ResponseEntity.ok().body(practiceStartResDto);
    }

}
