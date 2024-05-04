package org.example.back.db.repository;

import org.example.back.db.entity.RoomMember;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoomMemberRepository extends JpaRepository<RoomMember, Long> {
    Optional<RoomMember> findByRoomIdAndMemberId(Long roomId, Long memberId);
}
