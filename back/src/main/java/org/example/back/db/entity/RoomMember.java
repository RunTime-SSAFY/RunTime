package org.example.back.db.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.example.back.common.BaseEntity;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomMember extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private Room room; // 방의 id

    @ManyToOne
    @JoinColumn(name="member_id")
    private Member member; // 방에 참가한 사용자의 id

    private Boolean isReady; // 방에 참가한 사용자가 게임을 시작할 준비가 되었으면 true, 그렇지 않으면 false

}