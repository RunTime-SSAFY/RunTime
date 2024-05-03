package org.example.back.db.repository;

import org.example.back.db.entity.CurrentAchievement;
import org.example.back.db.entity.CurrentAchievementId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompletedAchievementRepository extends JpaRepository<CurrentAchievement, CurrentAchievementId> {
}