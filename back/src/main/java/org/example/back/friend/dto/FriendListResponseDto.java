package org.example.back.friend.dto;

import java.util.List;

import lombok.Builder;
import lombok.Data;

@Data
public class FriendListResponseDto {

	List<FriendResponseDto> friendList;
	boolean hasNext;

	@Builder
	public FriendListResponseDto(List<FriendResponseDto> friendList, boolean hasNext){
		this.friendList = friendList;
		this.hasNext = hasNext;
	}

}
