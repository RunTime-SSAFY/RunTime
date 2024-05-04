package org.example.back.achievement.service;

import java.util.List;

import org.example.back.achievement.dto.AchievementResDto;
import org.example.back.achievement.dto.CheckAchievementResDto;
import org.example.back.db.repository.AchievementRepository;
import org.example.back.util.SecurityUtil;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AchievementService {

	private final AchievementRepository achievementRepository;

	public List<AchievementResDto> findOwn() {
		//로그인한 사용자 id
		Long memberId = SecurityUtil.getCurrentMemberId();

		// 해당 사용자가 진행중인 도전과제 리스트.
		List<AchievementResDto> list = achievementRepository.findOwnAchievement(memberId);

		return list;
	}

	public CheckAchievementResDto checkAchievement() {
		Long memberId = SecurityUtil.getCurrentMemberId();
		List<AchievementResDto> list = achievementRepository.findOwnAchievement(memberId);

		list.forEach(el->{

		});
		return null;
	}
}
