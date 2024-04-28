package org.example.back.matching.controller;

import lombok.RequiredArgsConstructor;
import org.example.back.matching.service.MatchingService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/matchings")
public class MatchingController {

    private final MatchingService matchingService;
    @PostMapping("")
    public String matchingRequest() {
        matchingService.match();

        return "matching request test";
    }

    @GetMapping("/cancel")
    public String matchingCancel() {
        matchingService.cancel();
        return "matching cancel test";
    }
}
