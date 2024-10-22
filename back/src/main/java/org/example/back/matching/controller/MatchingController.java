package org.example.back.matching.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.back.matching.dto.MatchingReqDto;
import org.example.back.matching.dto.MatchingRankingResDto;
import org.example.back.matching.dto.ReadyReqDto;
import org.example.back.matching.service.MatchingService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/matchings")
public class MatchingController {

    private final MatchingService matchingService;
    @PatchMapping("")
    public ResponseEntity<Void> matchingRequest(@RequestBody MatchingReqDto matchingReqDto) throws InterruptedException {
        int difference = matchingReqDto.getDifference();
        matchingService.match(difference);

        return ResponseEntity.ok().build();
    }

    @PatchMapping("/cancel")
    public ResponseEntity<Void> matchingCancel() {
        matchingService.matchCancel();
        return ResponseEntity.ok().build();
    }

    @PatchMapping("/{matchingRoomId}/ready")
    public ResponseEntity<Void> matchingReady(@PathVariable Long matchingRoomId, @RequestBody ReadyReqDto readyReqDto) {
        boolean ready = readyReqDto.isReady();

        matchingService.ready(matchingRoomId, ready);


        return ResponseEntity.ok().build();

    }

    @PatchMapping("/{matchingRoomId}/exit")
    public ResponseEntity<Void> exit(@PathVariable Long matchingRoomId) {

        matchingService.exit(matchingRoomId);

        return ResponseEntity.ok().build();

    }

    @GetMapping("/{matchingRoomId}/ranking")
    public ResponseEntity<MatchingRankingResDto> ranking(@PathVariable Long matchingRoomId) throws JsonProcessingException {
        MatchingRankingResDto rankingResDto = matchingService.getRanking(matchingRoomId);

        return ResponseEntity.ok().body(rankingResDto);
    }

    @PatchMapping("/{matchingRoomId}/reenter")
    public ResponseEntity<Void> reenter(@PathVariable Long matchingRoomId) throws JsonProcessingException {
        matchingService.reenter(matchingRoomId);

        return ResponseEntity.ok().build();

    }

}
