package org.example.back.result.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.example.back.db.entity.Member;
import org.example.back.db.entity.Record;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.result.dto.ResultReqDto;
import org.example.back.result.dto.ResultResDto;
import org.example.back.util.S3Util;
import org.example.back.util.SecurityUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ResultService {

	private final RecordRepository recordRepository;
	private final MemberRepository memberRepository;
	private final S3Util s3Util;

	@Transactional
	public ResultResDto getResult(ResultReqDto record) throws IOException {  // 경기 기록 저장 및 저장 결과 반환
		// S3에 업로드할 파일 로드
		MultipartFile file = record.getFile();

		// 처리할 사용자 로드
		Member member = getMember();

		// 경기 결과 저장
		Long id = saveRecord(member, record, uploadFile(file));

		// 사용자 점수 갱신 및 저장, 갱신되기 전 점수 반환
		Integer beforeScore = updateMemberScores(member, record);

		// 갱신되기 전 점수를 이용해 갱신된 점수 반환
		return createResultResDto(id, member, beforeScore);
	}

	private Long saveRecord(Member member, ResultReqDto record, String url) {
		Record result =  Record.builder()
			.member(member)
			.gameMode(record.getGameMode())
			.ranking(record.getRanking())
			.distance(record.getDistance())
			.runStartTime(record.getRunStartTime())
			.runEndTime(record.getRunEndTime())
			.pace(record.getPace())
			.calorie(record.getCalorie())
			.courseImgUrl(url)
			.build();
		result.updateDuration();

		recordRepository.save(result);

		return result.getId();
	}

	private Integer updateMemberScores(Member member, ResultReqDto record) {
		int consecutive = record.getRanking().equals(1) ? member.getConsecutiveGames() + 1 : 0; // 연승 기록 갱신
		int beforeScore = member.getTierScore() != null ? member.getTierScore() : 0;  // 갱신 전 점수
		int updateScore = beforeScore + (record.getRanking().equals(1) ? 30 * consecutive : -30);  // 점수 갱신
		int afterScore = Math.min(Math.max(updateScore, 0), 1100);  // 점수 상한선 제한

		member.updateTierScore(afterScore);
		member.updateConsecutive(consecutive);
		memberRepository.save(member);

		return beforeScore;
	}

	private ResultResDto createResultResDto(Long id, Member member, int beforeScore) {
		int status = Integer.compare(member.getTierScore() / 100, beforeScore / 100);
		return new ResultResDto(id, beforeScore, member.getTierScore(), status, member.getConsecutiveGames());
	}

	private Member getMember() {  // 현재 사용 유저의 id 조회
		Long id = SecurityUtil.getCurrentMemberId();
		return memberRepository.findById(id).orElseThrow(MemberNotFoundException::new);
	}

	private String uploadFile(MultipartFile file) throws IOException {
		// 임시 파일 생성 및 파일 전송
		Path tempFile = Files.createTempFile("temp", file.getOriginalFilename());
		file.transferTo(tempFile.toFile());

		// 파일을 S3에 업로드하고 URL을 설정
		return s3Util.uploadFileOrImage("user_track_img", tempFile, getMember().getId());
	}
}
