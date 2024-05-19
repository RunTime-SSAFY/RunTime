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

import com.querydsl.core.Tuple;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.CaseBuilder;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.NumberPath;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
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
							.when(friend.requester.id.eq(id)).then(friend.addressee.id)
							.otherwise(friend.requester.id)
					).from(friend)
					.where(friend.status.eq(FriendStatusType.accepted)
						.and(friend.requester.id.eq(id).or(friend.addressee.id.eq(id)))
					))
			)
			// 마지막 조회된 id부터 조회
			.where(ltMemberId(lastId), member.id.ne(id))
			.orderBy(member.id.desc())
			.limit(pageable.getPageSize() + 1)
			.fetch();
		// dto로 매핑
		List<FriendResponseDto> list = new ArrayList<>();
		for (Member member : results) {
			list.add(FriendResponseDto.builder()
				.member(member)
					.isAlreadyRequest(true)
				.build());
		}
		return checkLastPage(pageable, list);
	}

	@Override
	public Slice<FriendResponseDto> findNotFriendMembers(Pageable pageable, Long id, Long lastId, String searchWord) {
		// 나와 친구가 아닌 모든 사용자 반환
		List<Tuple> results = query.select(member, JPAExpressions.select(friend.count())
				.from(friend)
				.where(friend.addressee.id.eq(member.id).and(friend.requester.id.eq(id))).exists()
				)
			.from(member)
			.where(member.id.notIn(
				// 사용자 중 나와 친구 관계가 "accepted"인 모든 사용자
				JPAExpressions.select(
						new CaseBuilder()
							.when(friend.requester.id.eq(id)).then(friend.addressee.id)
							.otherwise(friend.requester.id)
					).from(friend)
					.where(friend.status.eq(FriendStatusType.accepted)
						.and(friend.requester.id.eq(id).or(friend.addressee.id.eq(id)))
					))
			)
			// 마지막 조회된 id부터 조회
			.where(ltMemberId(lastId), member.id.ne(id), searchWord(searchWord), member.nickname.isNotNull())
			.orderBy(member.id.desc())
			.limit(pageable.getPageSize() + 1)
			.fetch();
		// dto로 매핑
		List<FriendResponseDto> list = new ArrayList<>();
		for (Tuple data : results) {
			log.info("member: {}\nrequest?: {}", data.get(member), Boolean.TRUE.equals(data.get(1, Boolean.class)));
			list.add(FriendResponseDto.builder()
				.member(data.get(member))
				.isAlreadyRequest(Boolean.TRUE.equals(data.get(1, boolean.class)))
				.build());
		}
		return checkLastPage(pageable, list);
	}

	private BooleanExpression searchWord(String searchWord) {
		if (searchWord == null) {
			return null;
		}
		return member.nickname.contains(searchWord);
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
	public int countFriends(Long memberId) {
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
