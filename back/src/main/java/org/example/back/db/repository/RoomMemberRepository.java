package org.example.back.db.repository;

import org.example.back.db.entity.RoomMember;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RoomMemberRepository extends JpaRepository<RoomMember, Long> {
    Optional<RoomMember> findByRoom_IdAndMember_Id(Long roomId, Long memberId);
    List<RoomMember> findBySessionId(String sessionId);
}
