package org.example.back.realtime_record.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.back.realtime_record.dto.SaveRealtimeRecordReqDto;
import org.example.back.realtime_record.dto.StompRealtimeReqDto;
import org.example.back.realtime_record.service.RealtimeRecordService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/realtime-records")
public class RealtimeRecordController {
    private final RealtimeRecordService realtimeRecordService;
    @PostMapping("")
    public ResponseEntity<List<StompRealtimeReqDto>> saveRealtimeRecord(@RequestBody SaveRealtimeRecordReqDto saveRealtimeRecordReqDto) throws JsonProcessingException {
            List<StompRealtimeReqDto> list = realtimeRecordService.saveRealtimeRecord(saveRealtimeRecordReqDto);

            return ResponseEntity.status(HttpStatus.CREATED).body(list);
    }


}
