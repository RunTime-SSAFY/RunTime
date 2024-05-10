package org.example.back.db.repository;

import org.example.back.achievement.dto.RecordSummaryResDto;
import org.example.back.db.entity.Member;
import org.example.back.db.enums.GameMode;
import org.example.back.record.dto.RecordDto;
import org.example.back.record.dto.StatisticDto;
import org.springframework.data.domain.Slice;

import java.time.LocalDate;

public interface RecordCustom {
    Slice<RecordDto> findAll(Long lastId, int pageSize, Member member, GameMode gameMode);

    RecordSummaryResDto getSummary(Long memberId);

    StatisticDto getStatisticByMonth(Member member, LocalDate selectedDate);
    StatisticDto getStatisticByYear(Member member, LocalDate selectedDate);
    StatisticDto getStatisticByAll(Member member);
}
