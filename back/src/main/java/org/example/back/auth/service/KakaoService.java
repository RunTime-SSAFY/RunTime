package org.example.back.auth.service;

import org.example.back.auth.dto.KakaoInfoResponse;

public interface KakaoService {
	String getToken(String code);

	KakaoInfoResponse getKakaoInfo(String accessToken);
}
