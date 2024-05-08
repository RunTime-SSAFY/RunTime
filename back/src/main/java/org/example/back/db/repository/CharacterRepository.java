package org.example.back.db.repository;

import org.example.back.db.entity.Character;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CharacterRepository extends JpaRepository<Character, Long>, CharacterCustom {

}