package org.example.back.auth.dto;

import org.antlr.v4.runtime.Token;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class JoinResponseDto {

	private Long id;
	private String email;

	TokenResponseDto tokenResponseDto;
}
