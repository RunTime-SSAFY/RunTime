package org.example.back.practice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.example.back.common.CustomException;
import org.example.back.db.entity.RealtimeRecord;
import org.example.back.db.entity.Record;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.RecordNotFoundException;
import org.example.back.practice.dto.PracticeRealtimeDto;
import org.example.back.practice.dto.PracticeStartResDto;
import org.example.back.realtime_record.dto.StompRealtimeReqDto;
import org.example.back.util.SecurityUtil;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PracticeService {

    private final RecordRepository recordRepository;
    private final RedisTemplate<String, String> redisTemplate;
    private final ObjectMapper objectMapper;

//    @Transactional
//    public PracticeResDto getPracticeResDto() {
//        // 나의 id 가져오기
//        Long myMemberId = SecurityUtil.getCurrentMemberId();
//
//        // 최근 10개의 기록 중 페이스가 가장 높은 기록의 id 가져오기
//        Long recordId = recordRepository.getBestRecordFromLastTenRecords(myMemberId);
//
//        // 그 기록의 실시간 정보들을 모두 가져오기
//        Record record = recordRepository.findById(recordId).orElseThrow(RecordNotFoundException::new);
//
//        List<PracticeRealtimeDto> realtimeRecords = record.getRealtimeRecords().stream().map(RealtimeRecord::toPracticeRealtimeDto).toList();
//
//        return PracticeResDto.builder().distance(realtimeRecords.get(0).getDistance()).data(realtimeRecords).build();
//
//    }

    public PracticeStartResDto reenter() throws JsonProcessingException {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        // lastIdx, lastDistance를 찾아 저장한다.
        StompRealtimeReqDto stompRealtimeReqDto = objectMapper.readValue(redisTemplate.opsForList().range("realtime_practice_"  + "memberId:" + myMemberId, -1, -1).get(0), StompRealtimeReqDto.class);
        int lastIdx = stompRealtimeReqDto.getIdx();
        double lastDistance = stompRealtimeReqDto.getDistance();

        redisTemplate.opsForValue().set("lastIdx_memberId:" + myMemberId, String.valueOf(lastIdx));
        redisTemplate.opsForValue().set("lastDistance_memberId:" + myMemberId, String.valueOf(lastDistance));

        UUID uuid = UUID.fromString(redisTemplate.opsForValue().get("uuid_practice_memberId:" + myMemberId));

        return PracticeStartResDto.builder().uuid(uuid).build();

    }

    public PracticeStartResDto startPractice() throws JsonProcessingException {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        // stomp 통신을 위한 uuid
        UUID uuid = UUID.randomUUID();
        redisTemplate.opsForValue().set("uuid_practice_memberId:" + myMemberId, uuid.toString()); // redis에 uuid 저장

        // redis에 고스트의 실시간 기록들을 저장한다

        // 최근 10개의 매칭전 기록 중 페이스가 가장 낮은 기록의 id 가져오기
        Long recordId = recordRepository.getBestRecordFromLastTenRecords(myMemberId);
        if (recordId == null) {
            throw new CustomException(HttpStatus.NOT_FOUND, "매칭전의 기록이 없어서 연습전을 진행할 수 없습니다");
        }

        // 그 기록의 실시간 정보들을 모두 가져오기
        Record record = recordRepository.findById(recordId).orElseThrow(RecordNotFoundException::new);
        List<PracticeRealtimeDto> realtimeRecords = record.getRealtimeRecords().stream().map(RealtimeRecord::toPracticeRealtimeDto).toList();

        redisTemplate.opsForValue().set("realtime_practice_ghost:" + myMemberId, objectMapper.writeValueAsString(realtimeRecords));

        return PracticeStartResDto.builder().uuid(uuid).build();

    }

}
