package org.example.back.redis.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@RedisHash(value="refreshToken", timeToLive = 60*60*24*4)
@AllArgsConstructor
public class RefreshToken {

	@Id
	private String refreshToken;
	private Long memberId;


}
