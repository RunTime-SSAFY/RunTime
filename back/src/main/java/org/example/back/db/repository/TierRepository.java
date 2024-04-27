package org.example.back.db.repository;

import org.example.back.db.entity.Tier;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TierRepository extends JpaRepository<Tier, Long> {
}