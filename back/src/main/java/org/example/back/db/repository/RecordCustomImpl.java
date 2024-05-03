package org.example.back.db.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.example.back.db.entity.QRecord;
import org.example.back.db.entity.Record;
import org.example.back.db.enums.GameMode;
import org.example.back.record.dto.RecordDto;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class RecordCustomImpl implements RecordCustom {

    private final JPAQueryFactory query;
    private final QRecord record = QRecord.record;

    @Override
    public Slice<RecordDto> findAll(Long lastId, int pageSize, GameMode gameMode) {
        Pageable pageable = PageRequest.of(1, pageSize);
        List<Record> records = query.selectFrom(record)
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

}
