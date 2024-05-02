package org.example.back.ranking.service;

import java.util.List;

import org.example.back.ranking.dto.RankerResDto;
import org.example.back.db.repository.RankerRepository;
import org.example.back.ranking.dto.RankingResDto;
import org.springframework.stereotype.Service;

import jakarta.persistence.Tuple;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RankingService {
	private final RankerRepository rankRepository;

	public RankingResDto getRanking() {
		List<Tuple> rankerList =  rankRepository.getTopMembersWithTierInfo();
		return new RankingResDto(rankerList.stream().map(
			ranker -> new RankerResDto(
			ranker.get("nickname", String.class),
			ranker.get("tierScore", Integer.class),
			ranker.get("tierName", String.class),
			ranker.get("tierImage", String.class)
			)).toList());
	}
}
