package org.example.back.redis.entity;

import org.springframework.data.annotation.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.redis.core.RedisHash;

import java.util.Set;

@RedisHash("matchingRoom")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MatchingRoom {
    @Id
    private Long id;

    Set<String> users; // 두 유저의 아이디를 string으로 변환한 것들의 집합
    Set<String> approved; // 게임 시작에 동의한 유저의 아이디를 string으로 변환한 것들의 집합
}
