package org.example.back.db.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.example.back.practice.dto.PracticeRealtimeDto;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RealtimeRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    private double distance;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="record_id")
    private Record record;

    private int idx;

    public PracticeRealtimeDto toPracticeRealtimeDto() {
        return PracticeRealtimeDto.builder().idx(idx).distance(distance).build();
    }

}
