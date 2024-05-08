package org.example.back.db.repository;

import org.example.back.friend.dto.FriendResponseDto;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

public interface MemberCustom {

	Slice<FriendResponseDto> findAllFriends(Pageable pageable, Long id, Long lastId);

	int countFriends(Long memberId);
}
