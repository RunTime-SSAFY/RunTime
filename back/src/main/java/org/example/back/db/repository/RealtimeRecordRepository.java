package org.example.back.db.repository;

import org.example.back.db.entity.RealtimeRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RealtimeRecordRepository extends JpaRepository<RealtimeRecord, Long> {
}
