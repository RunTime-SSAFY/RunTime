package org.example.back.auth.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TokenResponseDto {
	private String accessToken;
	private String refreshToken;
	private Boolean isNewMember;
}
