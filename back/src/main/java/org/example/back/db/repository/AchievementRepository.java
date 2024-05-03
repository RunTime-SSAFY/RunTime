package org.example.back.db.repository;

import java.util.List;

import org.example.back.db.entity.Achievement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import jakarta.persistence.Tuple;

public interface AchievementRepository extends JpaRepository<Achievement, Long>, AchievementCustom {

}