package org.example.back.matching.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.back.matching.dto.ApproveReqDto;
import org.example.back.matching.service.MatchingService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/matchings")
public class MatchingController {

    private final MatchingService matchingService;
    @PostMapping("")
    public String matchingRequest() throws JsonProcessingException {
        matchingService.match();

        return "matching request test";
    }

    @GetMapping("/cancel")
    public String matchingCancel() {
        matchingService.matchCancel();
        return "matching cancel test";
    }

    @PostMapping("/approve")
    public String matchingApprove(@RequestBody ApproveReqDto approveReqDto) {
        Long matchingRoomId = approveReqDto.getMatchingRoomId();
        boolean approve = approveReqDto.isApprove();
        if (approve) { // 매칭된 상대와 게임 시작에 동의
            matchingService.approve(matchingRoomId);
        } else { // 매칭된 상대와 게임 시작에 동의 취소
            matchingService.approveCancel(matchingRoomId);
        }

        return "matching approve test";
    }
}
