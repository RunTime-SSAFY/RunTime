package org.example.back.db.repository;

import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import org.example.back.achievement.dto.RecordSummaryResDto;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.QRecord;
import org.example.back.db.entity.Record;
import org.example.back.db.enums.GameMode;
import org.example.back.record.dto.RecordDto;
import org.example.back.record.dto.StatisticsDto;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class RecordCustomImpl implements RecordCustom {

    private final JPAQueryFactory query;
    private final QRecord record = QRecord.record;

    @Override
    public Slice<RecordDto> findAll(Long lastId, int pageSize, Member member, GameMode gameMode) {
        Pageable pageable = PageRequest.of(1, pageSize);
        List<Record> records = query.selectFrom(record)
                .where(record.member.eq(member))
                .where(record.gameMode.stringValue().contains(gameMode.name()))
                .where(ltRecordId(lastId))
                .orderBy(record.id.desc())
                .limit(pageSize + 1)
                .fetch();

        List<RecordDto> recordResponseDto = records.stream().map(Record::toRecordDto).toList();

        return checkLastPage(pageable, recordResponseDto);
    }

    private BooleanExpression ltRecordId(Long recordId) {
        if (recordId == null) return null;
        return record.id.lt(recordId);
    }

    private Slice<RecordDto> checkLastPage(Pageable pageable, List<RecordDto> results) {
        boolean hasNext = false;

        if(results.size() > pageable.getPageSize()) {
            hasNext = true;
            results.remove(pageable.getPageSize());
        }

        return new SliceImpl<>(results, pageable, hasNext);
    }

    @Override
    public RecordSummaryResDto getSummary(Long memberId){
        BooleanExpression isRankingFirst = record.ranking.eq(1);
		return query.select(Projections.bean(RecordSummaryResDto.class,
            record.distance.sum().coalesce(0f).as("totalDistance"), isRankingFirst.count().intValue().as("countWins"),
                record.duration
                    .sum().divide(3600000).floatValue().coalesce(0f)
                    .as("totalDuration") ))
            .from(record)
            .where(record.member.id.eq(memberId))
            .fetchOne();
    }

    @Override
    public StatisticsDto getStatisticsByMonth(Member member, LocalDate selectedDate) {
        LocalDate startDate = selectedDate.withDayOfMonth(1);
        LocalDate endDate = startDate.plusMonths(1).minusDays(1);
        return query
                .select(Projections.constructor(StatisticsDto.class,
                        record.count(),
                        record.calorie.sum(),
                        record.distance.sum(),
                        record.duration.sum()))
                .from(record)
                .where(record.member.eq(member)
                        .and(record.runStartTime.between(startDate.atStartOfDay(), endDate.atTime(23, 59, 59))))
                .fetchOne();
    }

    @Override
    public StatisticsDto getStatisticsByYear(Member member, LocalDate selectedDate) {
        LocalDate startDate = selectedDate.withDayOfYear(1);
        LocalDate endDate = startDate.plusYears(1).minusDays(1);
        return query
                .select(Projections.constructor(StatisticsDto.class,
                        record.count(),
                        record.calorie.sum(),
                        record.distance.sum(),
                        record.duration.sum()))
                .from(record)
                .where(record.member.eq(member)
                        .and(record.runStartTime.between(startDate.atStartOfDay(), endDate.atTime(23, 59, 59))))
                .fetchOne();
    }

    @Override
    public StatisticsDto getStatisticsByAll(Member member) {
        return query
                .select(Projections.constructor(StatisticsDto.class,
                        record.count(),
                        record.calorie.sum(),
                        record.distance.sum(),
                        record.duration.sum()))
                .from(record)
                .where(record.member.eq(member))
                .fetchOne();

    }

}
