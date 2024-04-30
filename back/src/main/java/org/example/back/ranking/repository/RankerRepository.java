package org.example.back.ranking.repository;

import java.util.List;

import org.example.back.db.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface RankerRepository extends JpaRepository<Member, Long> {
	@Query(value =
		"SELECT m.nickname, m.tier_score, t.name, t.img_url "
			+ "FROM (SELECT * FROM member ORDER BY tier_score DESC LIMIT 10) m "
			+ "JOIN tier t "
			+ "ON m.tier_score BETWEEN t.score_min AND t.score_max",
		nativeQuery = true)
	List<Object[]> getTopMembersWithTierInfo();
}