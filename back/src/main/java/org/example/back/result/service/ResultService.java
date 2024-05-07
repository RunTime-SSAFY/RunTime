package org.example.back.result.service;

import org.example.back.db.entity.Member;
import org.example.back.db.entity.Record;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.result.dto.ResultReqDto;
import org.example.back.result.dto.ResultResDto;
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
	public ResultResDto getResult(ResultReqDto record) {  // 경기 기록 저장 및 저장 결과 반환
		// 처리할 사용자 로드
		Member member = getMember();

		// 경기 결과 저장
		saveRecord(member, record);

		// 사용자 점수 갱신 및 저장
		updateMemberScores(member, record);

		return createResultResDto(member);
	}

	private void saveRecord(Member member, ResultReqDto record) {
		Record result =  Record.builder()
			.member(member)
			.gameMode(record.getGameMode())
			.ranking(record.getRanking())
			.distance(record.getDistance())
			.runStartTime(record.getRunStartTime())
			.runEndTime(record.getRunEndTime())
			.pace(record.getPace())
			.calorie(record.getCalorie())
			.duration(record.getDuration())
			.build();
		recordRepository.save(result);
	}

	private void updateMemberScores(Member member, ResultReqDto record) {
		int consecutive = record.getRanking().equals(1) ? member.getConsecutiveGames() + 1 : 0; // 연승 기록 갱신
		int beforeScore = member.getTierScore();  // 갱신 전 점수
		int updateScore = beforeScore + (record.getRanking().equals(1) ? 30 * consecutive : -30);  // 점수 갱신
		int afterScore = Math.min(Math.max(updateScore, 0), 1100);  // 점수 상한선 제한

		member.updateTierScore(afterScore);
		member.updateConsecutive(consecutive);
		memberRepository.save(member);
	}

	private ResultResDto createResultResDto(Member member) {
		int beforeScore = member.getTierScore();
		int status = Integer.compare(member.getTierScore() / 100, beforeScore / 100);
		return new ResultResDto(beforeScore, member.getTierScore(), status, member.getConsecutiveGames());
	}
}
