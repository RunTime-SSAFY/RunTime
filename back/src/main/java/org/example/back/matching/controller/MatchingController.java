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
    public ResponseEntity<Void> matchingRequest(){
        matchingService.match();

        return ResponseEntity.ok().build();
    }

    @PatchMapping("/cancel")
    public ResponseEntity<Void> matchingCancel() {
        matchingService.matchCancel();
        return ResponseEntity.ok().build();
    }

    @PatchMapping("/{matchingRoomId}/ready")
    public ResponseEntity<Void> matchingReady(@PathVariable Long matchingRoomId) {

        matchingService.ready(matchingRoomId);


        return ResponseEntity.ok().build();

    }

    @PatchMapping("/{matchingRoomId}/exit")
    public ResponseEntity<Void> exit(@PathVariable Long matchingRoomId) {

        matchingService.exit(matchingRoomId);

        return ResponseEntity.ok().build();

    }
}
