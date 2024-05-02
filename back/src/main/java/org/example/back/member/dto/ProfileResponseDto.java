package org.example.back.member.dto;

import org.example.back.db.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ProfileResponseDto {

	private String nickname;
	private Float weight;
	private Long characterId;

	@Builder
	public ProfileResponseDto(String nickname, Float weight, Long characterId) {
		this.nickname = nickname;
		this.weight = weight;
		this.characterId = characterId;
	}

	@Builder
	public ProfileResponseDto(Member member) {
		this.nickname = member.getNickname();
		this.weight = member.getWeight();
		this.characterId = member.getCharacter().getId();
	}
}
