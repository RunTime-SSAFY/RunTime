package org.example.back.auth.dto;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
public class TokenRequestDto {

	private String accessToken;
	private String refreshToken;
}
