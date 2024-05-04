package org.example.back.db.repository;

import org.example.back.db.entity.Record;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecordRepository extends JpaRepository<Record, Long>, RecordCustom {
}