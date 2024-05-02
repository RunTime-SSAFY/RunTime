package org.example.back.db.repository;

import org.example.back.db.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, Long>, MemberCustom {
	Boolean existsByEmail(String email);

	Member findByEmail(String email);
}