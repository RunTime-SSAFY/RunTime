package org.example.back.db.entity;

import jakarta.persistence.*;
import lombok.*;
import org.example.back.common.BaseEntity;
import org.example.back.db.enums.Status;
import org.example.back.room.dto.PostRoomResDto;
import org.example.back.room.dto.RoomResDto;

import java.util.List;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Room extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Setter
    @ManyToOne
    @JoinColumn(name = "manager_id")
    private Member manager; // 방장 id

    private String name; // 방 이름
    private double distance; // 방의 목표 거리
    private Status status; // 방의 상태: 대기 중 또는 진행 중
    private String password; // 비밀방의 비밀번호: 비밀방이 아닌 경우에는 null
    private int capacity; // 방의 정원
    private int headcount; // 방에 참여한 인원의 수

    @Setter
    @OneToMany(mappedBy = "room", cascade = CascadeType.REMOVE)
    private List<RoomMember> roomMembers;

    public PostRoomResDto toPostRoomResDto() {
        return PostRoomResDto.builder()
                .roomId(id)
                .name(name)
                .capacity(capacity)
                .distance(distance)
                .status(status.name())
                .password(password)
                .build();
    }

    public RoomResDto toRoomResDto() {
        return RoomResDto.builder()
                .roomId(id)
                .name(name)
                .capacity(capacity)
                .distance(distance)
                .status(status.name())
                .build();
    }

    public void patchRoomName(String name) {
        this.name = name;
    }


    public void patchRoomDistance(double distance) {
        this.distance = distance;
    }

    public void patchRoomPassword(String password) {
        this.password = password;
    }

    public void patchRoomCapacity(int capacity) {
        this.capacity = capacity;
    }

    public void startGame() {
        this.status = Status.IN_PROGRESS;
    }

}
