package org.example.back.friend.service;

import org.example.back.db.entity.Friend;
import org.example.back.db.entity.Member;
import org.example.back.db.enums.FriendStatusType;
import org.example.back.db.repository.FriendRepository;
import org.example.back.db.repository.MemberRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.friend.dto.FriendListResponseDto;
import org.example.back.friend.dto.FriendResponseDto;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional
	public Long request(Long addresseeId) {
		Long requesterId = SecurityUtil.getCurrentMemberId();

		// 사용자가 친구 요청, 별도의 검증 하지 않고 proxy 객체 사용
		Member requester = entityManager.getReference(Member.class, requesterId);
		// 요청 받는 사용자.  db에 존재하는지 확인
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

	@Transactional
	public Long accept(Long requesterId) {

		//사용자의 id, requester는 친구 요청을 보낸 사람
		Long id = SecurityUtil.getCurrentMemberId();

		// 해당 친구요청 정보를 찾아 status를 accepted로 변경
		Friend friend = friendRepository.findByRequesterIdAndAddresseeId(requesterId, id).orElseThrow(MemberNotFoundException::new);
		friend.updateStatus(FriendStatusType.accepted);
		friendRepository.save(friend);
		return requesterId;

	}

	@Transactional
	public Long reject(Long requesterId) {
		//사용자의 id, requester는 친구 요청을 보낸 사람
		Long id = SecurityUtil.getCurrentMemberId();


		// 해당 친구요청 정보를 찾아 status를 rejected로 변경
		Friend friend = friendRepository.findByRequesterIdAndAddresseeId(requesterId, id).orElseThrow(MemberNotFoundException::new);
		friend.updateStatus(FriendStatusType.rejected);
		friendRepository.save(friend);
		return requesterId;
	}
}
