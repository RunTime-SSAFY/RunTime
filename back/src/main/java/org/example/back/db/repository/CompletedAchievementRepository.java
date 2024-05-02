package org.example.back.db.repository;

import org.example.back.db.entity.CompletedAchievement;
import org.example.back.db.entity.CompletedAchievementId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompletedAchievementRepository extends JpaRepository<CompletedAchievement, CompletedAchievementId> {
}