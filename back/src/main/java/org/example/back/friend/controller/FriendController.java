package org.example.back.friend.controller;

import java.util.List;

import org.example.back.friend.dto.FriendListResponseDto;
import org.example.back.friend.dto.FriendResponseDto;
import org.example.back.friend.service.FriendService;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/friends")
@RequiredArgsConstructor
public class FriendController {

	private final FriendService friendService;

	@GetMapping
	public ResponseEntity<FriendListResponseDto> getFriends(Pageable pageable,
		@RequestParam(required = false) Long lastId) {
		FriendListResponseDto friendList = friendService.findAllFriends(pageable, lastId);
		return ResponseEntity.ok(friendList);
	}

	@GetMapping("/others")
	public ResponseEntity<FriendListResponseDto> getOtherMembers(Pageable pageable,
		@RequestParam(required = false) Long lastId, @RequestParam(required = false) String searchWord) {
		FriendListResponseDto otherList = friendService.findNotFriends(pageable, lastId, searchWord);
		return ResponseEntity.ok(otherList);
	}

	@PostMapping("/{addresseeId}")
	public ResponseEntity<Long> requestFriend(@PathVariable Long addresseeId) {
		Long id = friendService.request(addresseeId);
		return ResponseEntity.status(HttpStatus.CREATED).body(addresseeId);
	}

	@PatchMapping("/{requesterId}")
	public ResponseEntity<Long> acceptFriend(@PathVariable Long requesterId) {
		Long id = friendService.accept(requesterId);
		return ResponseEntity.ok(id);
	}

	@DeleteMapping("/{requesterId}")
	public ResponseEntity<Long> rejectFriend(@PathVariable Long requesterId) {
		Long id = friendService.reject(requesterId);
		return ResponseEntity.status(HttpStatus.NO_CONTENT).body(id);
	}

	@GetMapping("/requests")
	public ResponseEntity<List<FriendResponseDto>> getFriendsRequests(){
		List<FriendResponseDto> friendListResponseDto = friendService.getFriendsRequests();
		return ResponseEntity.ok(friendListResponseDto);

	}
}
