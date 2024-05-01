package org.example.back.ranking.controller;

import java.util.List;

import org.example.back.ranking.dto.RankerDto;
import org.example.back.ranking.service.RankingService;
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
	public List<RankerDto> getRankerList() {
		return rankingService.getRanking();
	}
}
