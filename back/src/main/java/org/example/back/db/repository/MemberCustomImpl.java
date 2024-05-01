package org.example.back.db.repository;

import java.util.List;

import org.example.back.db.entity.Member;
import org.example.back.db.entity.QCharacter;
import org.example.back.db.entity.QFriend;
import org.example.back.db.entity.QMember;
import org.example.back.friend.dto.FriendResponseDto;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Repository;

import com.querydsl.core.Tuple;
import com.querydsl.core.types.dsl.CaseBuilder;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberCustomImpl implements MemberCustom {

	private final JPAQueryFactory query;

	private final QMember member = QMember.member;
	private final QFriend friend = QFriend.friend;
	private final QCharacter character = QCharacter.character;

	@Override
	public Slice<FriendResponseDto> findAll(Pageable pageable, Long id) {
		List<Member> results = query.selectFrom(member)
			.from(member)
			.where(member.id.in(
				JPAExpressions.select(
					new CaseBuilder()
						.when(friend.requester.id.eq(1L)).then(friend.addressee.id)
						.otherwise(friend.requester.id)
				).from(friend)
				.where(friend.status.eq("accepted")
					.and(friend.requester.id.eq(id).or(friend.addressee.id.eq(id)))
				))
			).fetch();

		return null;
	}
}
