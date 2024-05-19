package org.example.back.matching.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back.common.CustomException;
import org.example.back.db.entity.Member;
import org.example.back.db.enums.Status;
import org.example.back.db.repository.MemberRepository;
import org.example.back.exception.MatchingRoomNotFoundException;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.exception.ReenterForbiddenException;
import org.example.back.exception.RoomNotFoundException;
import org.example.back.matching.dto.*;
import org.example.back.realtime_record.dto.StompRealtimeReqDto;
import org.example.back.redis.entity.MatchingRoom;
import org.example.back.redis.repository.MatchingRoomRepository;
import org.example.back.util.SecurityUtil;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class MatchingService {
    private final RedisTemplate<String, String> redisTemplate;
    private final MatchingRoomRepository matchingRoomRepository;
    private final MemberRepository memberRepository;
    private final SimpMessagingTemplate messagingTemplate;
    private final ObjectMapper objectMapper;

    public void match(int difference) { // 매칭 대기열에 나를 추가한다
        // 로그인 된 멤버 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        Member me = memberRepository.findById(myMemberId).orElseThrow(MemberNotFoundException::new);

        int tierScore = me.getTierScore();
        int consecutiveGames = me.getConsecutiveGames();
        ZSetOperations<String, String> zSetOperations = redisTemplate.opsForZSet();
        // 로그인 된 멤버가 세 번 이상으로 연속 승리하고 있는 경우
        Long opponentMemberId = null;
        if (consecutiveGames >= 3) {
            Set<String> values = zSetOperations.reverseRangeByScore("matching", tierScore - difference, tierScore + difference);
            if (!values.isEmpty()) {
                opponentMemberId = Long.parseLong(values.iterator().next());
            }

            else {
                log.info("opponentMemberId is null");
            }
        }

        // 로그인 된 멤버가 세 번 이상으로 연속승리하고 있지 않은 경우
        else {
            Set<String> values = zSetOperations.rangeByScore("matching", tierScore - difference, tierScore + difference);
            if (!values.isEmpty()) {
                opponentMemberId = Long.parseLong(values.iterator().next());
            }

            else {
                log.info("opponentMemberId is null");
            }
        }

        // 상대방이랑 매칭이 된 경우
        if (opponentMemberId != null) {

            // 그 사람을 매칭 대기열에서 제거한다.
            redisTemplate.opsForZSet().remove("matching", String.valueOf(opponentMemberId));

            Set<String> members = new HashSet<>();
            members.add(String.valueOf(myMemberId));
            members.add(String.valueOf(opponentMemberId));

            MatchingRoom matchingRoom = MatchingRoom.builder()
                    .members(members)
                    .status(Status.WAITING)
                    .build();

            MatchingRoom savedMatchingRoom = matchingRoomRepository.save(matchingRoom); // 매칭룸을 생성한다

            UUID uuid = UUID.randomUUID(); // 방의 stomp 연결을 위한 랜덤 스트링
            redisTemplate.opsForValue().set("uuid_matchingRoomId:" + savedMatchingRoom.getId(), uuid.toString()) ; // uuid 저장

            Member opponent = memberRepository.findById(opponentMemberId).orElseThrow(MemberNotFoundException::new);

            OpponentResDto firstOpponentResDto = OpponentResDto.builder()
                    .matchingRoomId(matchingRoom.getId())
                    .uuid(uuid)
                    .memberId(opponentMemberId)
                    .nickname(opponent.getNickname())
                    .characterImgUrl(opponent.getCharacter().getImgUrl())
                    .build();

            StompMatchingSuccessResDto firstStompMatchingSuccessResDto = StompMatchingSuccessResDto.builder()
                    .action("matching")
                    .data(firstOpponentResDto)
                    .build();

            OpponentResDto secondOpponentResDto = OpponentResDto.builder()
                    .matchingRoomId(matchingRoom.getId())
                    .uuid(uuid)
                    .memberId(myMemberId)
                    .nickname(me.getNickname())
                    .characterImgUrl(me.getCharacter().getImgUrl())
                    .build();

            StompMatchingSuccessResDto secondStompMatchingSuccessResDto = StompMatchingSuccessResDto.builder()
                    .data(secondOpponentResDto)
                    .action("matching")
                    .build();

            messagingTemplate.convertAndSend("/queue/member/" + me.getNickname(), firstStompMatchingSuccessResDto);
            messagingTemplate.convertAndSend("/queue/member/" + opponent.getNickname(), secondStompMatchingSuccessResDto);

        }

        // 상대방이랑 매칭이 되지 않은 경우: 자신을 매칭 대기열에 추가한다.
        else {
            redisTemplate.opsForZSet().add("matching", String.valueOf(myMemberId), tierScore);
        }



    }

    public void matchCancel() { // 매칭 대기열에서 나를 제외한다
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        redisTemplate.opsForZSet().remove("matching", String.valueOf(myMemberId));

    }

    public void ready(Long matchingRoomId, boolean ready) {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        // 매칭룸을 redis에서 찾는다
        MatchingRoom matchingRoom = matchingRoomRepository.findById(matchingRoomId).orElseThrow(() -> new RuntimeException("해당 id를 지닌 matchingRoom이 존재하지 않습니다"));
        // 매칭룸에 연관된 uuid 가져온다
        String uuid = redisTemplate.opsForValue().get("uuid_matchingRoomId:" + matchingRoomId);
        // 한 명이라도 동의하지 않으면, 매칭방은 삭제되고 게임이 시작될 수 없음을 알려준다.
        if (!ready) {
            matchingRoomRepository.deleteById(matchingRoomId);
            StompGameStartResDto stompGameStartResDto = StompGameStartResDto.builder().action("start").data(false).build();
            messagingTemplate.convertAndSend("/topic/matchingRoom/" + uuid, stompGameStartResDto);
            return;
        }

        // readyMembers에서 나의 id를 추가한다.

        if (matchingRoom.getReadyMembers() == null) {
                Set<String> readyMembers = new HashSet<>();
                readyMembers.add(String.valueOf(myMemberId));
                matchingRoom.setReadyMembers(readyMembers);
        }

        else {
                matchingRoom.getReadyMembers().add(String.valueOf(myMemberId));
        }

        matchingRoomRepository.save(matchingRoom);

        // approved의 개수가 2인 경우
        if (matchingRoom.getReadyMembers().size() == 2) {
            matchingRoom.setStatus(Status.IN_PROGRESS);

            String[] membersId = new String[2];

            Set<String> membersSet = matchingRoom.getMembers();
            Iterator<String> iterator = membersSet.iterator();

            int idx = 0;
            while (iterator.hasNext()) {
                String next = iterator.next();
                membersId[idx] = next;
                idx++;
            }

            StompGameStartResDto stompGameStartResDto = StompGameStartResDto.builder()
                    .action("start")
                    .data(true)
                    .build();

            // matchingRoom의 두 유저들에게 게임이 시작되었음을 알려준다
            messagingTemplate.convertAndSend("/topic/matchingRoom/" + uuid, stompGameStartResDto);

        }

    }

    public void exit(Long matchingRoomId) {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        // 매칭룸을 redis에서 찾는다
        MatchingRoom matchingRoom = matchingRoomRepository.findById(matchingRoomId).orElseThrow(() -> new RuntimeException("해당 id를 지닌 matchingRoom이 존재하지 않습니다"));

        // uuid 가져온다
        String uuid = redisTemplate.opsForValue().get("uuid_matchingRoomId:" + matchingRoomId);

        // approved 및 members에서 String.valueOf(myMemberId) 제거
        if (matchingRoom.getReadyMembers() != null) {
            matchingRoom.getReadyMembers().remove(String.valueOf(myMemberId));
        }

        // 매칭방의 멤버들에서 나 삭제
        matchingRoom.getMembers().remove(String.valueOf(myMemberId));
        matchingRoom.getReadyMembers().remove(String.valueOf(myMemberId));

        // 매칭방에 아무도 안 남아 있다면 매칭방 삭제
        if (matchingRoom.getMembers().isEmpty()) {
           deleteMatchingRoom(matchingRoomId);
        }

        // matchingRoom update
        matchingRoomRepository.save(matchingRoom);

        // 만약 lastIdx, lastDistance가 있다면, 삭제
        redisTemplate.delete("lastIdx_memberId:" + myMemberId);
        redisTemplate.delete("lastIdx_memberId:" + myMemberId);

        StompGameExitResDto stompGameExitResDto = StompGameExitResDto.builder()
                .action("exit").build();

        messagingTemplate.convertAndSend("/topic/matchingRoom/" + uuid, stompGameExitResDto);

    }

    public MatchingRankingResDto getRanking(Long matchingRoomId) throws JsonProcessingException {
        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        // 멤버가 완주했는 지 확인한다
        ListOperations<String, String> listOperations = redisTemplate.opsForList();
        List<String> stompRealtimeReqDtoList =  listOperations.range("realtime_matchingRoomId:" + matchingRoomId + "memberId:" + myMemberId, -1, -1);
        if (stompRealtimeReqDtoList == null || stompRealtimeReqDtoList.isEmpty()) throw new CustomException(HttpStatus.BAD_REQUEST, myMemberId + "는 " + matchingRoomId + "매칭전을 완주하지 못했습니다");

        StompRealtimeReqDto stompRealtimeReqDto = objectMapper.readValue(stompRealtimeReqDtoList.get(0), StompRealtimeReqDto.class);
        if (stompRealtimeReqDto.getDistance() < 100) throw new CustomException(HttpStatus.BAD_REQUEST, matchingRoomId + "매칭전을 완주하지 못했습니다"); // 매칭전은 1KM 고정

        // 멤버를 완주한 목록에 추가한다
        redisTemplate.opsForList().rightPush("ranking_matchingRoomId:" + matchingRoomId, String.valueOf(myMemberId));

        // 등수를 가져온다
        Long ranking = redisTemplate.opsForList().size("ranking_matchingRoomId:" + matchingRoomId);

        return MatchingRankingResDto.builder().ranking(ranking).build();

    }

    public void reenter(Long matchingRoomId) throws JsonProcessingException {
        // matchingRoom이 있는지 확인한다
        MatchingRoom matchingRoom = matchingRoomRepository.findById(matchingRoomId).orElseThrow(() -> new MatchingRoomNotFoundException(matchingRoomId));

        // 나의 id 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        Member me = memberRepository.findById(myMemberId).orElseThrow(MemberNotFoundException::new);
        String myNickname = me.getNickname();

        //  재입장 가능한지 확인한다
        if (!matchingRoom.getStatus().name().equals("IN_PROGRESS") || !redisTemplate.hasKey("realtime_matchingRoomId:" + matchingRoomId + "memberId:" + myMemberId)) {
            throw new ReenterForbiddenException(matchingRoomId);
        }

        // uuid를 가져온다
        UUID uuid = UUID.fromString(Objects.requireNonNull(redisTemplate.opsForValue().get("uuid_matchingRoomId:" + matchingRoomId)));

        // 상대방(이미 매칭방에서 게임을 진행하고 있는 멤버)의 id와 닉네임을 가져온다.
        Long opponentId = Long.parseLong(new ArrayList<>(matchingRoom.getMembers()).get(0));
        Member opponent = memberRepository.findById(opponentId).orElseThrow(MemberNotFoundException::new);
        String opponentNickname = opponent.getNickname();

        // redis의 matchingRoom에 나 추가한다
        matchingRoom.getMembers().add(String.valueOf(myMemberId));
        matchingRoom.getReadyMembers().add(String.valueOf(myMemberId));

        matchingRoomRepository.save(matchingRoom);

        // lastIdx와 lastDistance를 가져온다
        StompRealtimeReqDto stompRealtimeReqDto = objectMapper.readValue(redisTemplate.opsForList().range("realtime_matchingRoomId:" + matchingRoomId + "memberId:" + myMemberId, -1, -1).get(0), StompRealtimeReqDto.class);
        int lastIdx = stompRealtimeReqDto.getIdx();
        double lastDistance = stompRealtimeReqDto.getLon();

        // lastIdx와 lastDistance를 저장한다
        redisTemplate.opsForValue().set("lastIdx_memberId:" + myMemberId, String.valueOf(lastIdx));
        redisTemplate.opsForValue().set("lastDistance_memberId:" + myMemberId, String.valueOf(lastDistance));

        // 나에게 stomp로 StompMatching SuccessResDto 보내한다
        OpponentResDto opponentResDto = OpponentResDto.builder()
                .matchingRoomId(matchingRoomId)
                .uuid(uuid)
                .memberId(opponentId)
                .nickname(opponentNickname)
                .characterImgUrl(opponent.getCharacter().getImgUrl())
                .build();

        StompMatchingSuccessResDto stompMatchingSuccessResDto = StompMatchingSuccessResDto.builder().action("matching").data(opponentResDto).build();

        messagingTemplate.convertAndSend("/queue/member/" + myNickname, stompMatchingSuccessResDto);

    }

    public void deleteMatchingRoom(Long matchingRoomId) {
        matchingRoomRepository.deleteById(matchingRoomId);

        redisTemplate.delete("uuid_matchingRoomId:" + matchingRoomId);
        redisTemplate.delete("ranking_matchingRoomId:" + matchingRoomId);

    }



}
