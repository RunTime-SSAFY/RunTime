package org.example.back.record.controller;

import lombok.RequiredArgsConstructor;
import org.example.back.record.dto.RecordListResponseDto;
import org.example.back.record.dto.RecordResponseDto;
import org.example.back.record.dto.StatisticsResponseDto;
import org.example.back.record.service.RecordService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/records")
public class RecordController {
    private final RecordService recordService;


    // 기록 조회
    @GetMapping("")
    public ResponseEntity<RecordListResponseDto> getAllRecords(
            @RequestParam(value = "lastId",required = false) Long lastId,
            @RequestParam("pageSize") Integer pageSize
    ) {
        return null;
    }

    // 기록 상세 조회
    @GetMapping("/{recordId}")
    public ResponseEntity<RecordResponseDto> getRecord(@PathVariable Long recordId) {
        return null;
    }
    // 통계 조회
    @GetMapping("/statistics/{year}/{month}")
    public ResponseEntity<StatisticsResponseDto> getStatistics(
            @PathVariable int year,
            @PathVariable int month
    ) {
        return null;
    }

}
