package org.example.back.db.repository;

import java.util.Optional;

import org.example.back.db.entity.Friend;
import org.example.back.db.enums.FriendStatusType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FriendRepository extends JpaRepository<Friend, Long>, FriendCustom{
	Optional<Friend> findByRequesterIdAndAddresseeId(Long requesterId, Long id);


}