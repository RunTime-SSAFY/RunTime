package org.example.back.result.service;

import java.util.Optional;

import org.example.back.db.entity.Member;
import org.example.back.db.entity.Record;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.result.dto.ResultDto;
import org.example.back.util.SecurityUtil;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ResultService {

	private final RecordRepository recordRepository;
	private final MemberRepository memberRepository;

	private Member getMember() {  // 현재 사용 유저의 id 조회
		Long id = SecurityUtil.getCurrentMemberId();
		return memberRepository.findById(id).orElseThrow(MemberNotFoundException::new);
	}

	public ResultDto getResult() {
		Long memberId = getMember().getId();
		
		Record record = recordRepository.findByMemberId(memberId);
		ResultDto resultDto = new ResultDto();
		resultDto.setId(record.getId());
		resultDto.setMemberId(memberId);
		resultDto.setType(record.getType());
		resultDto.setRanking(record.getRanking());
		resultDto.setDistance(record.getDistance());
		resultDto.setDuration(record.getDuration());
		resultDto.setAvgSpeed(record.getAvgSpeed());
		resultDto.setPace(record.getPace());
		resultDto.setCalorie(record.getCalorie());
		return resultDto;
	}
}
