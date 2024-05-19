package org.example.back.friend.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.example.back.db.entity.Friend;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.Notification;
import org.example.back.db.entity.Tier;
import org.example.back.db.enums.NotificationStatusType;
import org.example.back.db.enums.NotificationType;
import org.example.back.db.enums.FriendStatusType;
import org.example.back.db.repository.FriendRepository;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.NotificationRepository;
import org.example.back.db.repository.TierRepository;
import org.example.back.exception.FriendAlreadyExistException;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.friend.dto.FriendListResponseDto;
import org.example.back.friend.dto.FriendResponseDto;
import org.example.back.util.FcmUtil;
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
	private final TierRepository tierRepository;
	private final NotificationRepository notificationRepository;

	private final FcmUtil fcmUtil;

	@PersistenceContext
	private EntityManager entityManager;

	@Transactional
	public Long request(Long addresseeId) {
		Long requesterId = SecurityUtil.getCurrentMemberId();

		if (Objects.equals(addresseeId, requesterId)) {
			throw new MemberNotFoundException();
		}

		// // 사용자가 친구 요청, 별도의 검증 하지 않고 proxy 객체 사용
		// Member requester = entityManager.getReference(Member.class, requesterId);

		Member requester = memberRepository.findById(requesterId).orElseThrow(MemberNotFoundException::new);
		// 요청 받는 사용자.  db에 존재하는지 확인
		Member addressee = memberRepository.findById(addresseeId).orElseThrow(MemberNotFoundException::new);

		Friend friend = friendRepository.searchFriendRequest(requesterId, addresseeId);

		// 아직 친구 요청을 보낸 적이 없다면 새로 생성
		if (friend == null) {
			friend = Friend.builder()
				.requester(requester)
				.addressee(addressee)
				.status(FriendStatusType.pending)
				.build();
		} else {
			// 친구요청을 보낸 적이 있고 거절당했다면 새로 신청
			if (friend.getStatus().equals(FriendStatusType.rejected)) {
				friend.updateRequesterAndAddressee(requester, addressee);
				friend.updateStatus(FriendStatusType.pending);
				//     현재 진행중인 요청이 있거나 이미 친구인 경우. 이미 요청되었다는 Exception
			} else {
				throw new FriendAlreadyExistException();
			}
		}
		friendRepository.save(friend);

		// FCM 알림 전송
		String messageBody = requester.getNickname() + "님이 친구요청을 보내셨습니다.";

		// 알림 정보 저장
		Notification notification = Notification.builder()
			.member(addressee)
			.type(NotificationType.FRIEND)
			.targetId(requesterId)
			.detail(messageBody)
			.status(NotificationStatusType.UNREAD)
			.build();
		long notificationId = notificationRepository.save(notification).getId();

		fcmUtil.sendAlert(notificationId, NotificationType.FRIEND, "친구 요청", messageBody, addressee, requesterId);

		return addresseeId;
	}

	public FriendListResponseDto findAllFriends(Pageable pageable, Long lastId) {
		Long id = SecurityUtil.getCurrentMemberId();
		Slice<FriendResponseDto> result = memberRepository.findAllFriends(pageable, id, lastId);
		List<Tier> tierList = tierRepository.findAll();
		for (FriendResponseDto friendResponseDto : result.getContent()) {
			int score = friendResponseDto.getTierScore();
			for (Tier tier : tierList) {
				if (score >= tier.getScoreMin() && score <= tier.getScoreMax()) {
					friendResponseDto.setTierImgUrl(tier.getImgUrl());
				}
			}
		}

		return FriendListResponseDto.builder()
			.friendList(result.getContent())
			.hasNext(result.hasNext())
			.build();
	}

	@Transactional
	public Long accept(Long requesterId) {

		//사용자의 id, requester는 친구 요청을 보낸 사람
		Long id = SecurityUtil.getCurrentMemberId();
		Member requester = memberRepository.findById(requesterId).orElseThrow(MemberNotFoundException::new);
		Member addressee = memberRepository.findById(id).orElseThrow(MemberNotFoundException::new);

		// 해당 친구요청 정보를 찾아 status를 accepted로 변경
		Friend friend = friendRepository.findByRequesterIdAndAddresseeId(requesterId, id)
			.orElseThrow(MemberNotFoundException::new);
		friend.updateStatus(FriendStatusType.accepted);
		friendRepository.save(friend);

		// 친구요청 수락했다는 알림 전송
		String messageBody = addressee.getNickname() + "님이 친구요청을 수락하셨습니다.";

		// 알림 정보 저장
		Notification notification = Notification.builder()
			.member(requester)
			.type(NotificationType.FRIEND)
			.targetId(addressee.getId())
			.detail(messageBody)
			.status(NotificationStatusType.UNREAD)
			.build();
		notificationRepository.save(notification);
		long notificationId = notificationRepository.save(notification).getId();

		fcmUtil.sendAlert(notificationId, NotificationType.FRIEND, "친구 수락", messageBody, requester, addressee.getId());

		return requesterId;

	}

	@Transactional
	public Long reject(Long requesterId) {
		//사용자의 id, requester는 친구 요청을 보낸 사람
		Long id = SecurityUtil.getCurrentMemberId();

		// 해당 친구요청 정보를 찾아 status를 rejected로 변경
		Friend friend = friendRepository.searchFriendRequest(requesterId, id);
		if (friend == null) {
			throw new MemberNotFoundException();
		}
		friend.updateStatus(FriendStatusType.rejected);
		friendRepository.save(friend);
		return requesterId;
	}

	public FriendListResponseDto findNotFriends(Pageable pageable, Long lastId, String searchWord) {

		Long id = SecurityUtil.getCurrentMemberId();
		Slice<FriendResponseDto> result = memberRepository.findNotFriendMembers(pageable, id, lastId, searchWord);
		List<Tier> tierList = tierRepository.findAll();
		for (FriendResponseDto friendResponseDto : result.getContent()) {
			int score = friendResponseDto.getTierScore();
			for (Tier tier : tierList) {
				if (score >= tier.getScoreMin() && score <= tier.getScoreMax()) {
					friendResponseDto.setTierImgUrl(tier.getImgUrl());
				}
			}
		}

		return FriendListResponseDto.builder()
			.friendList(result.getContent())
			.hasNext(result.hasNext())
			.build();
	}

	public List<FriendResponseDto> getFriendsRequests() {
		Long memberId = SecurityUtil.getCurrentMemberId();

		List<Friend> friendList = friendRepository.findByAddresseeIdAndStatus(memberId, FriendStatusType.pending);
		List<FriendResponseDto> friendResponseDtoList = new ArrayList<>();

		List<Tier> tierList = tierRepository.findAll();
		for (Friend friend : friendList) {

			FriendResponseDto friendResponseDto = FriendResponseDto.builder()
				.member(friend.getRequester())
				.isAlreadyRequest(true)
				.build();

			int score = friend.getRequester().getTierScore();
			for (Tier tier : tierList) {
				if (score >= tier.getScoreMin() && score <= tier.getScoreMax()) {
					friendResponseDto.setTierImgUrl(tier.getImgUrl());
				}
			}

			friendResponseDtoList.add(friendResponseDto);
		}
		return friendResponseDtoList;

	}
}