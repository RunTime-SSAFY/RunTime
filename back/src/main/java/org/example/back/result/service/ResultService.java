package org.example.back.result.service;

import org.example.back.db.entity.Member;
import org.example.back.db.entity.Record;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.result.dto.ResultReqDto;
import org.example.back.result.dto.TierResDto;
import org.example.back.util.SecurityUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional
	public ResultReqDto getResult(ResultReqDto record) {
		Record result = new Record();
		result.setMember(getMember());
		result.setType(record.getType());
		result.setRanking(record.getRanking());
		result.setDistance(record.getDistance());
		result.setDuration(record.getDuration());
		result.setAvgSpeed(record.getAvgSpeed());
		result.setPace(record.getPace());
		result.setCalorie(record.getCalorie());
		recordRepository.save(result);

		return new ResultReqDto(result.getId(),
			result.getMember().getId(),
			result.getType(),
			result.getRanking(),
			result.getDistance(),
			result.getDuration(),
			result.getAvgSpeed(),
			result.getPace(),
			result.getCalorie());
	}

	@Transactional
	public TierResDto updateScore() {
		int consecutive, beforeScore, afterScore, status;
		Member member = getMember();
		Record record = recordRepository.findByMemberId(member.getId());

		consecutive = record.getRanking().equals(1) ? member.getConsecutiveGames() + 1 : 0; // 연승 기록 갱신
		beforeScore = member.getTierScore();  // 갱신 전 점수
		afterScore = Math.min(Math.max(beforeScore + (record.getRanking().equals(1) ? 30 * consecutive : -30), 0), 1100);  // 점수 상한선 제한

		member.updateTierScore(afterScore);  // 갱신 점수 저장
		member.updateConsecutive(consecutive);  // 갱신 연승 기록 저장
		memberRepository.save(member);  // db 저장

		status = Integer.compare(afterScore / 100, beforeScore / 100);

		return new TierResDto(beforeScore, afterScore, status);
	}
}
