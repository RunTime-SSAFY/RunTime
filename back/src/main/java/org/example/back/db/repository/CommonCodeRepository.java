package org.example.back.db.repository;

import org.example.back.db.entity.CommonCode;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommonCodeRepository extends JpaRepository<CommonCode, Integer> {
}