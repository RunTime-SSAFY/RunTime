package org.example.back.auth.service;

import org.example.back.auth.dto.KakaoInfoResponse;
import org.example.back.auth.dto.KakaoToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KakaoService {

	@Value("${oauth.kakao.client_id}")
	private String API_KEY;

	@Value("${oauth.kakao.redirect_uri}")
	private String REDIRECT_URI;

	@Value("${jwt.secret}")
	private String secretKey;

	private final RestTemplate restTemplate;

	public String getToken(String code) {
		String access_token = "";
		String refresh_token = "";
		String requestURL = "https://kauth.kakao.com/oauth/token";
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("grant_type", "authorization_code");
		body.add("client_id", API_KEY);
		body.add("redirect_uri", REDIRECT_URI);
		body.add("code", code);

		KakaoToken response = restTemplate.postForObject(requestURL, new HttpEntity<>(body, headers), KakaoToken.class);

		Assert.notNull(response, "잘못된 요청입니다.");

		access_token = response.getAccessToken();
		refresh_token = response.getRefreshToken();

		return access_token;
	}

	public KakaoInfoResponse getKakaoInfo(String accessToken) {
		String url = "https://kapi.kakao.com/v2/user/me";

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		httpHeaders.set("Authorization", "Bearer " + accessToken);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("property_keys", "[\"kakao_account.email\", \"kakao_account.profile\"]");

		HttpEntity<?> request = new HttpEntity<>(body, httpHeaders);

		return restTemplate.postForObject(url, request, KakaoInfoResponse.class);
	}

}
