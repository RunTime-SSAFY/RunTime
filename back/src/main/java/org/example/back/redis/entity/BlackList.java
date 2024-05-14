package org.example.back.redis.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@RedisHash(value="blackList")
@AllArgsConstructor
public class BlackList {

	@Id
	private String refreshToken;
	private Long memberId;
	@TimeToLive
	private Long expiration = 1L;


}
