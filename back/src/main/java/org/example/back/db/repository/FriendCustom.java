package org.example.back.db.repository;

import org.example.back.db.entity.Friend;

public interface FriendCustom {

	Friend searchFriendRequest(Long memberId);
}
