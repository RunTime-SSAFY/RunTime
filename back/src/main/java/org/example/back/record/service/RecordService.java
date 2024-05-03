package org.example.back.record.service;

import lombok.RequiredArgsConstructor;
import org.example.back.db.entity.Member;
import org.example.back.db.enums.GameMode;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.record.dto.RecordDto;
import org.example.back.record.dto.RecordListResponseDto;
import org.example.back.record.dto.RecordResponseDto;
import org.example.back.record.dto.StatisticsResponseDto;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RecordService {
    private final MemberRepository memberRepository;
    private final RecordRepository recordRepository;

    @Transactional(readOnly = true)
    public RecordListResponseDto getAllRecords(Long lastId, Integer pageSize, GameMode gameMode) {
        Member member = getMember();

        Slice<RecordDto> recordSlice = recordRepository.findAll(lastId, pageSize, gameMode);

        List<RecordDto> recordDtoList = recordSlice.getContent();
        boolean hasNextPage = recordSlice.hasNext();

        return new RecordListResponseDto(recordDtoList, hasNextPage);
    }

    @Transactional(readOnly = true)
    public RecordResponseDto getRecord(Long recordId) {
        Member member = getMember();

        return null;
    }

    @Transactional(readOnly = true)
    public StatisticsResponseDto getStatistics(Integer year, Integer month) {
        Member member = getMember();

        return null;
    }










    private Member getMember() {
        return memberRepository.findById(SecurityUtil.getCurrentMemberId())
                .orElseThrow(MemberNotFoundException::new);
    }

}
