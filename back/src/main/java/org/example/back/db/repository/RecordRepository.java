package org.example.back.db.repository;

import org.example.back.db.entity.Record;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface RecordRepository extends JpaRepository<Record, Long>, RecordCustom {
	@Query("SELECT r "
		+ "FROM Record r "
		+ "WHERE r.id = (SELECT MAX(r2.id) FROM Record r2 WHERE r2.member.id = :memberId)")
	Record findTopByMemberIdOrderByIdDesc(Long memberId);
}