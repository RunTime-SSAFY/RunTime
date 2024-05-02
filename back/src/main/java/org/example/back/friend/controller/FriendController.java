package org.example.back.friend.controller;

import org.example.back.friend.dto.FriendListResponseDto;
import org.example.back.friend.dto.FriendResponseDto;
import org.example.back.friend.service.FriendService;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
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
	public ResponseEntity<FriendListResponseDto> getFriends(Pageable pageable, @RequestParam(required = false) Long lastId){
		FriendListResponseDto friendList = friendService.findAllFriends(pageable, lastId);
		return ResponseEntity.ok(friendList);
	}

	@PostMapping("/{addresseeId}")
	public ResponseEntity<Long> requestFriend(@PathVariable Long addresseeId){
		Long id = friendService.request(addresseeId);
		return ResponseEntity.status(HttpStatus.CREATED).body(addresseeId);
	}

}
