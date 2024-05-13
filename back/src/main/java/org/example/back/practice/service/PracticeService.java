package org.example.back.practice.service;

import lombok.RequiredArgsConstructor;
import org.example.back.db.entity.RealtimeRecord;
import org.example.back.db.entity.Record;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.RecordNotFoundException;
import org.example.back.practice.dto.PracticeRealtimeDto;
import org.example.back.practice.dto.PracticeResDto;
import org.example.back.util.SecurityUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PracticeService {

    private final RecordRepository recordRepository;

    @Transactional
    public PracticeResDto getPracticeResDto() {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        // 최근 10개의 기록 중 페이스가 가장 높은 기록의 id 가져오기
        Long recordId = recordRepository.getBestRecordFromLastTenRecords(myMemberId);

        // 그 기록의 실시간 정보들을 모두 가져오기
        Record record = recordRepository.findById(recordId).orElseThrow(RecordNotFoundException::new);

        List<PracticeRealtimeDto> realtimeRecords = record.getRealtimeRecords().stream().map(RealtimeRecord::toPracticeRealtimeDto).toList();

        return PracticeResDto.builder().distance(realtimeRecords.get(0).getDistance()).data(realtimeRecords).build();

    }
}
