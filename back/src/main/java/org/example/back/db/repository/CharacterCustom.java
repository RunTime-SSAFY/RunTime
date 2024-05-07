package org.example.back.db.repository;

import org.example.back.db.entity.Character;

public interface CharacterCustom {
	Character findByAchievementTypeAndGrade(Long achievementTypeId,int grade);
}
