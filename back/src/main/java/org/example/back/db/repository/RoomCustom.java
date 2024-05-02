package org.example.back.db.repository;

import org.example.back.room.dto.RoomResDto;
import org.springframework.data.domain.Slice;

public interface RoomCustom {
    Slice<RoomResDto> findAll(Long lastId, int pageSize, String searchWord, boolean isSecret);
}
