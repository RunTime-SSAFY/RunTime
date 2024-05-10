package org.example.back.db.repository;

import org.example.back.db.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long>, MemberCustom {
	Boolean existsByEmail(String email);

	Member findByEmail(String email);

	Optional<Member> findByNickname(String nickname);
}