package org.example.back.ranking.service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.example.back.db.entity.Member;
import org.example.back.ranking.dto.RankerDto;
import org.example.back.ranking.repository.RankerRepository;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RankingService {
	private final RankerRepository rankerRepository;

	public List<RankerDto> getRanking() {
		List<Object[]> rankerList =  rankerRepository.getTopMembersWithTierInfo();
		return rankerList.stream().map(
			ranker -> new RankerDto(
				(String)ranker[0],
				(Integer)ranker[1],
				(String)ranker[2],
				(String)ranker[3]
			)).collect(Collectors.toList());
	}
}
