package org.example.back.db.repository;

import org.example.back.db.entity.Achievement;
import org.example.back.db.entity.AchievementType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AchievementTypeRepository extends JpaRepository<AchievementType, Long> {

}