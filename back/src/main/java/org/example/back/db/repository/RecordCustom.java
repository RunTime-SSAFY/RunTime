package org.example.back.db.repository;

import org.example.back.db.entity.Member;
import org.example.back.db.enums.GameMode;
import org.example.back.record.dto.RecordDto;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

public interface RecordCustom {
    Slice<RecordDto> findAll(Long lastId, int pageSize, Member member, GameMode gameMode);
}
