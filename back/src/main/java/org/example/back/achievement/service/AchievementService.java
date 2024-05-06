package org.example.back.achievement.service;

import java.util.ArrayList;
import java.util.List;

import org.example.back.achievement.dto.AchievementResDto;
import org.example.back.achievement.dto.CheckAchievementResDto;
import org.example.back.achievement.dto.RecordSummaryResDto;
import org.example.back.db.entity.AchievementType;
import org.example.back.db.entity.CurrentAchievement;
import org.example.back.db.entity.CurrentAchievementId;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.Record;
import org.example.back.db.repository.AchievementRepository;
import org.example.back.db.repository.CurrentAchievementRepository;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.util.SecurityUtil;
import org.springframework.stereotype.Service;

import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AchievementService {

	private final AchievementRepository achievementRepository;
	private final RecordRepository recordRepository;
	private final CurrentAchievementRepository currentAchievementRepository;
	private final EntityManager entityManager;

	public List<AchievementResDto> findOwn() {
		//로그인한 사용자 id
		Long memberId = SecurityUtil.getCurrentMemberId();

		// 해당 사용자가 진행중인 도전과제 리스트.
		List<AchievementResDto> list = achievementRepository.findOwnAchievement(memberId);

		return list;
	}

	public CheckAchievementResDto updateAchievement() {
		Long memberId = SecurityUtil.getCurrentMemberId();


		List<AchievementResDto> achievementlist = achievementRepository.findOwnAchievement(memberId);
		RecordSummaryResDto recordSummary = recordRepository.getSummary(memberId);
		System.out.println(recordSummary);

		CheckAchievementResDto resDto = new CheckAchievementResDto(false);

		achievementlist.forEach(achievement->{
			// 업데이트할 진행중 도전과제 객체
			CurrentAchievement currentAchievement = CurrentAchievement.builder()
				.id(new CurrentAchievementId(memberId, achievement.getType()))
				.progress(achievement.getProgress())
				.isReceived(achievement.getIsReceive())
				.currentGrade(achievement.getGrade())
				.build();
			switch (achievement.getCriteria()){
				case DISTANCE -> {
					currentAchievement.updateProgress(recordSummary.getTotalDistance()/ achievement.getGoal()*100);
				}
				case DURATION -> {
					currentAchievement.updateProgress(recordSummary.getTotalDuration()/ achievement.getGoal()*100);
				}
				case COUNT_WINS -> {
					currentAchievement.updateProgress(recordSummary.getCountWins()/ achievement.getGoal()*100);
				}
				case COUNT_FRIENDS -> {

				}
			}
			if(currentAchievement.getProgress()>=100.0&& !achievement.getIsReceive()){
				currentAchievement.updateProgress(100.0f);
				resDto.setHasReward(true);
			}
			currentAchievementRepository.save(currentAchievement);
		});
		return resDto;
	}
}
