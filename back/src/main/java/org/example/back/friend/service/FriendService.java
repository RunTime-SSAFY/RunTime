package org.example.back.friend.service;

import org.example.back.db.entity.Friend;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.enumType.FriendStatusType;
import org.example.back.db.repository.FriendRepository;
import org.example.back.db.repository.MemberRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.friend.dto.FriendListResponseDto;
import org.example.back.friend.dto.FriendResponseDto;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FriendService {

	private final FriendRepository friendRepository;
	private final MemberRepository memberRepository;
	@PersistenceContext
	private EntityManager entityManager;

	public Long request(Long addresseeId) {
		Long requesterId = SecurityUtil.getCurrentMemberId();

		Member requester = entityManager.getReference(Member.class, requesterId);
		Member addressee = memberRepository.findById(addresseeId).orElseThrow(MemberNotFoundException::new);

		Friend friend = Friend.builder()
			.requester(requester)
			.addressee(addressee)
			.status(FriendStatusType.pending)
			.build();

		friendRepository.save(friend);

		return addresseeId;
	}

	public FriendListResponseDto findAllFriends(Pageable pageable, Long lastId) {
		Long id = SecurityUtil.getCurrentMemberId();
		Slice<FriendResponseDto> result = memberRepository.findAllFriends(pageable, id, lastId);

		return FriendListResponseDto.builder()
			.friendList(result.getContent())
			.hasNext(result.hasNext())
			.build();
	}
}
