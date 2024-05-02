package org.example.back.ranking.controller;

import java.util.List;

import org.example.back.ranking.dto.RankerResDto;
import org.example.back.ranking.dto.RankingResDto;
import org.example.back.ranking.service.RankingService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/rankings")
public class RankingController {

	private final RankingService rankingService;
	@GetMapping
	public ResponseEntity<RankingResDto> getRanking() {
		return ResponseEntity.ok(rankingService.getRanking());
	}
}