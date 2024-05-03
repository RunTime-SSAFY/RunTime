package org.example.back.db.repository;

import org.example.back.db.entity.UnlockedCharacter;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UnlockedCharacterRepository extends JpaRepository<UnlockedCharacter, Long> {


}
