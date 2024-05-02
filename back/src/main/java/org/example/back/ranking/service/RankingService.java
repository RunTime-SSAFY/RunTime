package org.example.back.ranking.service;

import java.util.List;
import java.util.stream.Collectors;

import org.example.back.ranking.dto.RankerDto;
import org.example.back.ranking.repository.RankerRepository;
import org.springframework.stereotype.Service;

import jakarta.persistence.Tuple;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RankingService {
	private final RankerRepository rankerRepository;

	public List<RankerDto> getRanking() {
		List<Tuple> rankerList =  rankerRepository.getTopMembersWithTierInfo();
		return rankerList.stream().map(
			ranker -> new RankerDto(
				ranker.get("nickname", String.class),
				ranker.get("tierScore", Integer.class),
				ranker.get("tierName", String.class),
				ranker.get("tierImage", String.class)
			)).collect(Collectors.toList());
	}
}
