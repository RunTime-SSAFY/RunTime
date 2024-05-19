package org.example.back.db.repository;

import java.util.List;

import org.example.back.db.entity.Member;
import org.example.back.ranking.dto.RankerResDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import jakarta.persistence.Tuple;

public interface RankerRepository extends JpaRepository<Member, Long> {
	@Query(value =
		"SELECT m.nickname, m.tier_score tierScore, t.name tierName, t.img_url tierImage "
			+ "FROM (SELECT * FROM member ORDER BY tier_score DESC LIMIT 10) m "
			+ "JOIN tier t "
			+ "ON m.tier_score BETWEEN t.score_min AND t.score_max "
			+ "ORDER BY tier_score DESC",
		nativeQuery = true)
	List<Tuple> getTopMembersWithTierInfo();

	@Query("SELECT new org.example.back.ranking.dto.RankerResDto(m.nickname, m.tierScore, t.name, t.imgUrl) "
			+ "FROM Member m "
			+ "JOIN Tier t "
			+ "ON m.tierScore BETWEEN t.scoreMin AND t.scoreMax "
			+ "WHERE m.id = :id")
	RankerResDto getRankWithTierInfo(Long id);
}