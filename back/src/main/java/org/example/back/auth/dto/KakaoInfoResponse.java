package org.example.back.auth.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class KakaoInfoResponse{

	@JsonProperty("kakao_account")
	private KakaoAccount kakaoAccount;

	@Getter
	@JsonIgnoreProperties(ignoreUnknown = true)
	@Data
	static class KakaoAccount {
		private KakaoProfile profile;
		private String email;
	}

	@Getter
	@JsonIgnoreProperties(ignoreUnknown = true)
	@Data
	static class KakaoProfile {
		private String nickname;
	}

	public String getEmail() {
		return kakaoAccount.email;
	}

	public String getNickname() {
		return kakaoAccount.profile.nickname;
	}

}