package org.example.back.db.repository;

import java.util.ArrayList;
import java.util.List;

import org.example.back.db.entity.Member;
import org.example.back.db.entity.QCharacter;
import org.example.back.db.entity.QFriend;
import org.example.back.db.entity.QMember;
import org.example.back.db.enums.FriendStatusType;
import org.example.back.friend.dto.FriendResponseDto;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.stereotype.Repository;

import com.querydsl.core.types.dsl.BooleanExpression;
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
	public Slice<FriendResponseDto> findAllFriends(Pageable pageable, Long id, Long lastId) {
		// 나와 친구인 모든 사용자 반환
		List<Member> results = query.selectFrom(member)
			.where(member.id.in(
				// 사용자 중 나와 친구 관계가 "accepted"인 모든 사용자
				JPAExpressions.select(
						new CaseBuilder()
							.when(friend.requester.id.eq(1L)).then(friend.addressee.id)
							.otherwise(friend.requester.id)
					).from(friend)
					.where(friend.status.eq(FriendStatusType.accepted)
						.and(friend.requester.id.eq(id).or(friend.addressee.id.eq(id)))
					))
			)
			// 마지막 조회된 id부터 조회
			.where(ltMemberId(lastId))
			.orderBy(member.id.desc())
			.limit(pageable.getPageSize()+1)
			.fetch();
		// dto로 매핑
		List<FriendResponseDto> list = new ArrayList<>();
		for (Member member : results) {
			list.add(FriendResponseDto.builder()
				.member(member)
				.build());
		}
		return checkLastPage(pageable, list);
	}

	private BooleanExpression ltMemberId(Long lastId) {
		// 마지막으로 조회한 사용자 id가 null이면 무시됨.
		if (lastId == null) {
			return null;
		}
		return member.id.lt(lastId);
	}

	private Slice<FriendResponseDto> checkLastPage(Pageable pageable, List<FriendResponseDto> results) {
		// 마지막 페이지인지 확인하는 메소드.
		boolean hasNext = false;
		// 조회한 결과 개수가 요청한 페이지 사이즈보다 크면 뒤에 더 있음, next = true
		if (results.size() > pageable.getPageSize()) {
			hasNext = true;
			results.remove(pageable.getPageSize());
		}

		return new SliceImpl<>(results, pageable, hasNext);
	}


	@Override
	public int countFriends(Long memberId){
		return query.select(member.id.count()).
			from(member)
			.where(member.id.in(
				// 사용자 중 나와 친구 관계가 "accepted"인 모든 사용자
				JPAExpressions.select(
						new CaseBuilder()
							.when(friend.requester.id.eq(1L)).then(friend.addressee.id)
							.otherwise(friend.requester.id)
					).from(friend)
					.where(friend.status.eq(FriendStatusType.accepted)
						.and(friend.requester.id.eq(memberId).or(friend.addressee.id.eq(memberId)))
					))
			)
			.fetchFirst().intValue();
	}


}
