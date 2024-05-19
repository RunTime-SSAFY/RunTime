package org.example.back.character.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class CharacterResDto {
	private Long id;
	private String achievementName;
	private Boolean isHidden;
	private String name;
	private String detail;
	private String imgUrl;
	private Boolean isCheck;
	private Boolean unlockStatus;

}
