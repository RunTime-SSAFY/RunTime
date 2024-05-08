package org.example.back.db.repository;

import java.util.Optional;

import org.example.back.db.entity.Achievement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AchievementRepository extends JpaRepository<Achievement, Long>, AchievementCustom {

	Optional<Achievement> findByAchievementTypeIdAndGrade(Long achievementTypeId, Integer currentGrade);
}