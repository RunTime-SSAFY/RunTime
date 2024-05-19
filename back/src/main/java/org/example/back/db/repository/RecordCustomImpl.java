package org.example.back.db.repository;

import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.example.back.achievement.dto.RecordSummaryResDto;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.QRecord;
import org.example.back.db.entity.Record;
import org.example.back.db.enums.GameMode;
import org.example.back.record.dto.RecordDto;
import org.example.back.record.dto.StatisticDto;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
@Slf4j
public class RecordCustomImpl implements RecordCustom {

    private final JPAQueryFactory query;
    private final QRecord record = QRecord.record;

    @Override
    public Slice<RecordDto> findAll(Long lastId, int pageSize, Member member, GameMode gameMode) {
        Pageable pageable = PageRequest.of(1, pageSize);
        List<Record> records = query.selectFrom(record)
                .where(record.member.eq(member))
                .where(isFilterGameMode(gameMode))
                .where(ltRecordId(lastId))
                .orderBy(record.id.desc())
                .limit(pageSize + 1)
                .fetch();

        List<RecordDto> recordResponseDto = records.stream().map(Record::toRecordDto).collect(Collectors.toList());

        return checkLastPage(pageable, recordResponseDto);
    }
    private BooleanExpression isFilterGameMode(GameMode gameMode) {
        if(gameMode == null) return null;
        return record.gameMode.stringValue().contains(gameMode.name());
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
    public StatisticDto getStatisticByMonth(Member member, LocalDate selectedDate) {
        LocalDate startDate = selectedDate.withDayOfMonth(1);
        LocalDate endDate = startDate.plusMonths(1).minusDays(1);
        return query
                .select(Projections.constructor(StatisticDto.class,
                        record.count().intValue(), // Long to Integer 변환
                        record.calorie.sum().intValue(), // BigDecimal to Integer 변환
                        record.distance.sum().floatValue(), // BigDecimal to Float 변환
                        record.duration.sum().longValue())) // BigDecimal to Long 변환
                .from(record)
                .where(record.member.eq(member)
                        .and(record.runStartTime.between(startDate.atStartOfDay(), endDate.atTime(23, 59, 59))))
                .fetchOne();
    }

    @Override
    public StatisticDto getStatisticByYear(Member member, LocalDate selectedDate) {
        LocalDate startDate = selectedDate.withDayOfYear(1);
        LocalDate endDate = startDate.plusYears(1).minusDays(1);
        return query
                .select(Projections.constructor(StatisticDto.class,
                        record.count().intValue(), // Long to Integer 변환
                        record.calorie.sum().intValue(), // BigDecimal to Integer 변환
                        record.distance.sum().floatValue(), // BigDecimal to Float 변환
                        record.duration.sum().longValue())) // BigDecimal to Long 변환
                .from(record)
                .where(record.member.eq(member)
                        .and(record.runStartTime.between(startDate.atStartOfDay(), endDate.atTime(23, 59, 59))))
                .fetchOne();
    }

    @Override
    public StatisticDto getStatisticByAll(Member member) {
        return query
                .select(Projections.constructor(StatisticDto.class,
                        record.count().intValue(), // Long to Integer 변환
                        record.calorie.sum().intValue(), // BigDecimal to Integer 변환
                        record.distance.sum().floatValue(), // BigDecimal to Float 변환
                        record.duration.sum().longValue())) // BigDecimal to Long 변환
                .from(record)
                .where(record.member.eq(member))
                .fetchOne();
    }

    @Override
    public boolean existsDoubleSevenDuration(Long memberId) {
        return query.selectOne()
            .from(record)
            .where(record.duration.mod(100L).eq(77L), record.member.id.eq(memberId))
            .fetchFirst()!=null;
    }

    @Override
    public List<Integer> findRunDate(Long memberId,int year, int month) {
        log.info("runDate : {}", month);
        return query
            .select(record.runStartTime.dayOfMonth())
            .from(record)
            .where(record.member.id.eq(memberId), record.runStartTime.month().eq(month), record.runStartTime.year().eq(year))
            .fetch();
    }

    @Override
    public Long getBestRecordFromLastTenRecords(Long myMemberId) {
        return query
                .select(record.id)
                .from(record)
                .where(record.member.id.eq(myMemberId).and(record.gameMode.eq(GameMode.BATTLE)))
                .orderBy(record.createdAt.desc(), record.pace.asc())
                .fetchOne();
    }

}
