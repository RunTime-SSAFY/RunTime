package org.example.back.matching.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.back.matching.dto.ApproveReqDto;
import org.example.back.matching.dto.GameExitReqDto;
import org.example.back.matching.service.MatchingService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/matchings")
public class MatchingController {

    private final MatchingService matchingService;
    @PatchMapping("")
    public ResponseEntity<Void> matchingRequest() throws JsonProcessingException {
        matchingService.match();

        return ResponseEntity.ok().build();
    }

    @PatchMapping("/cancel")
    public ResponseEntity<Void> matchingCancel() {
        matchingService.matchCancel();
        return ResponseEntity.ok().build();
    }

    @PatchMapping("/approve")
    public ResponseEntity<Void> matchingApprove(@RequestBody ApproveReqDto approveReqDto) {
        Long matchingRoomId = approveReqDto.getMatchingRoomId();
        boolean approve = approveReqDto.isApprove();
        if (approve) { // 매칭된 상대와 게임 시작에 동의
            matchingService.approve(matchingRoomId);
        } else { // 매칭된 상대와 게임 시작에 동의 취소
            matchingService.approveCancel(matchingRoomId);
        }

        return ResponseEntity.ok().build();

    }

    @PatchMapping("/game-exit")
    public ResponseEntity<Void> gameExit(@RequestBody GameExitReqDto gameExitReqDto) {
        Long matchingRoomId = gameExitReqDto.getMatchingRoomId();

        matchingService.gameExit(matchingRoomId);

        return ResponseEntity.ok().build();

    }
}
