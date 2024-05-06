package org.example.back.db.repository;

import org.example.back.db.entity.Character;
import org.example.back.db.entity.CurrentAchievement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface CurrentAchievementRepository extends JpaRepository<CurrentAchievement, Long> {

}