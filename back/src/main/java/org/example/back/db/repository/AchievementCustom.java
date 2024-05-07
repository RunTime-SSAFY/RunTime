package org.example.back.db.repository;

import java.util.List;

import org.example.back.achievement.dto.AchievementResDto;

public interface AchievementCustom {

	public List<AchievementResDto> findOwnAchievement(Long memberId);
}
