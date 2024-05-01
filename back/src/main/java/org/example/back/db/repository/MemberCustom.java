package org.example.back.db.repository;

import org.example.back.friend.dto.FriendResponseDto;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

public interface MemberCustom {

	Slice<FriendResponseDto> findAll(Pageable pageable, Long id);
}
