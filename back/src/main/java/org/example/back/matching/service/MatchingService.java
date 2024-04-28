package org.example.back.matching.service;

import lombok.RequiredArgsConstructor;
import org.example.back.redis.entity.MatchingRoom;
import org.example.back.redis.repository.MatchingRoomRepository;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class MatchingService {
    private final RedisTemplate<String, String> redisTemplate;
    private final MatchingRoomRepository matchingRoomRepository;
    public void match() {
        // TODO 나의 id 가져오기
        Long myMemberId = 1L;
        redisTemplate.opsForZSet().add("matching", String.valueOf(myMemberId), System.currentTimeMillis());

        Long testId= 2L;
        redisTemplate.opsForZSet().add("matching", String.valueOf(testId), System.currentTimeMillis());


        // matching sorted set의 크기가 2이상일 때, 맨 앞 두명을 매칭시킨다
        Long waitingNum = redisTemplate.opsForZSet().zCard("matching");
        if (waitingNum >= 2) {
            Set<String> toMatchUsers = new HashSet<>();
            Set<String> range = redisTemplate.opsForZSet().range("matching",0, 1);
            Iterator<String> iterator = range.iterator();

            int idx = 0;
            while (iterator.hasNext()) {
                String next = iterator.next();
                toMatchUsers.add(next);
                idx++;
                redisTemplate.opsForZSet().remove("matching", next);
            }

            // TODO toMatchUsers들에게 matching이 성사되었다고 알려준다.
            MatchingRoom matchingRoom = MatchingRoom.builder()
                    .users(toMatchUsers)
                    .approved(new HashSet<>())
                    .build();

            matchingRoomRepository.save(matchingRoom); // 매칭룸을 생성한다

        }



    }

    public void cancel() {
        // TODO 나의 id 가져오기
        Long myMemberId = 1L;

        redisTemplate.opsForZSet().remove("matching", String.valueOf(myMemberId));

    }


}
