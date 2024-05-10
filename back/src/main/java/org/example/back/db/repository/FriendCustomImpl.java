package org.example.back.db.repository;

import org.example.back.db.entity.Friend;
import org.example.back.db.entity.QFriend;
import org.springframework.stereotype.Repository;

import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class FriendCustomImpl implements FriendCustom{

	private final JPAQueryFactory query;

	private final QFriend friend = QFriend.friend;

	@Override
	public Friend searchFriendRequest(Long requesterId, Long adderesseeId){
		return query.selectFrom(friend)
			.where(friend.requester.id.eq(requesterId).and(friend.addressee.id.eq(adderesseeId)).or(friend.addressee.id.eq(requesterId).and(friend.requester.id.eq(adderesseeId))))
			.fetchFirst();
	}
}
