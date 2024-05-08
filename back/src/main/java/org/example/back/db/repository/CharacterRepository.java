package org.example.back.db.repository;

import org.example.back.character.dto.CharacterResDto;
import org.example.back.db.entity.Character;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CharacterRepository extends JpaRepository<Character, Long>, CharacterCustom {
	@Query("SELECT new org.example.back.character.dto.CharacterResDto(c.id, c.achievement.id, c.name, c.detail, c.imgUrl, "
		+ "CASE WHEN uc.id.memberId IS NOT NULL "
		+ "THEN TRUE "
		+ "ELSE FALSE "
		+ "END) "
		+ "FROM Character c "
		+ "LEFT JOIN UnlockedCharacter uc "
		+ "ON c.id = uc.id.characterId AND uc.id.memberId = :id")
	Page<CharacterResDto> findAll(Long id, Pageable pageable);
}