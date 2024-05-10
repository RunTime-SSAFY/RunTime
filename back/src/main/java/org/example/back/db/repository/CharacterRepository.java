package org.example.back.db.repository;

import org.example.back.character.dto.CharacterResDto;
import org.example.back.db.entity.Character;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CharacterRepository extends JpaRepository<Character, Long>, CharacterCustom {
	@Query("SELECT new org.example.back.character.dto.CharacterResDto(c.id, c.achievement.id, c.name, c.detail, c.imgUrl, "
		+ "CASE WHEN uc.isCheck IS NULL "
		+ "THEN FALSE "
		+ "ELSE TRUE "
		+ "END, "
		+ "CASE WHEN uc.id.memberId IS NOT NULL "
		+ "THEN TRUE "
		+ "ELSE FALSE "
		+ "END) "
		+ "FROM Character c "
		+ "LEFT JOIN UnlockedCharacter uc "
		+ "ON c.id = uc.id.characterId AND uc.id.memberId = :memberId")
	Page<CharacterResDto> findAll(Long memberId, Pageable pageable);
	// 페이지 타입으로 받는 이유는, <Data, offset> 형태로 페이지의 마지막 유무를 확인하는 데이터가 따로 관리되어야 하기 때문

	@Query("SELECT new org.example.back.character.dto.CharacterResDto(c.id, c.achievement.id, c.name, c.detail, c.imgUrl, "
		+ "CASE WHEN uc.isCheck IS NULL "
		+ "THEN FALSE "
		+ "ELSE TRUE "
		+ "END, "
		+ "CASE WHEN uc.id.memberId IS NOT NULL "
		+ "THEN TRUE "
		+ "ELSE FALSE "
		+ "END) "
		+ "FROM Character c "
		+ "LEFT JOIN UnlockedCharacter uc "
		+ "ON c.id = uc.id.characterId AND uc.id.memberId = :memberId "
		+ "WHERE c.id = :id")
	CharacterResDto findByCharacterIdAndMemberId(Long id, Long memberId);
}