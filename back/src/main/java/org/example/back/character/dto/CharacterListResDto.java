package org.example.back.character.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class CharacterListResDto {
	private List<CharacterResDto> characterDtoList;
	private boolean isLast;
}
