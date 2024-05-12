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
	private Integer tierScore;
	private String tierName;
	private String tierImage;


	@Builder
	public ProfileResponseDto(String nickname, Float weight, Long characterId, Integer tierScore, String tierName, String tierImage) {
		this.nickname = nickname;
		this.weight = weight;
		this.characterId = characterId;
		this.tierScore = tierScore;
		this.tierName = tierName;
		this.tierImage = tierImage;
	}

	@Builder
	public ProfileResponseDto(Member member) {
		this.nickname = member.getNickname();
		this.weight = member.getWeight();
		this.characterId = member.getCharacter().getId();
	}
}
