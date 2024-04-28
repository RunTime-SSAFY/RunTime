package org.example.back.auth.kakao.service;

import org.example.back.auth.kakao.dto.KakaoInfoResponse;

public interface KakaoService {
	String getToken(String code);

	KakaoInfoResponse getKakaoInfo(String accessToken);
}
