package org.example.back.redis.entity;

import lombok.*;
import org.example.back.db.enums.Status;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;

import java.util.Set;

@RedisHash("matchingRoom")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MatchingRoom {
    @Id
    private Long id;

    Set<String> members; // 두 유저의 아이디를 string으로 변환한 것들의 집합
    Set<String> readyMembers; // 게임 시작에 동의한 유저의 아이디를 string으로 변환한 것들의 집합
    Enum<Status> status; // 방의 상태: 대기 중 또는 진행 중

}
