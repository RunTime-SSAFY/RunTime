package org.example.back.friend.dto;

import org.example.back.db.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FriendResponseDto {

	private Long id;
	private String name;
	private String characterImgUrl;

	@Builder
	public FriendResponseDto(Member member) {
		this.id = member.getId();
		this.name = member.getNickname();
		this.characterImgUrl = member.getCharacter().getImgUrl();
	}


}
