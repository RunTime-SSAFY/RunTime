package org.example.back.db.repository;

import java.util.Optional;

import org.example.back.db.entity.Character;
import org.example.back.db.entity.CurrentAchievement;
import org.example.back.db.entity.CurrentAchievementId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface CurrentAchievementRepository extends JpaRepository<CurrentAchievement, Long> {

	Optional<CurrentAchievement> findById(CurrentAchievementId id);
}