package org.example.back.db.entity;

import java.time.Duration;
import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.*;
import org.example.back.common.BaseEntity;

import org.example.back.db.enums.GameMode;
import org.example.back.record.dto.RecordDto;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
@Table(name = "record")
public class Record extends BaseEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "member_id", nullable = false)
	private Member member;

	@Lob
	@Enumerated(EnumType.STRING)
	@Column(name = "game_mode")
	private GameMode gameMode;

	@Column(name = "ranking")
	private Integer ranking;

	@Column(name = "distance")
	private Float distance;

	@Column(name = "run_start_time")
	private LocalDateTime runStartTime;

	@Column(name = "run_end_time")
	private LocalDateTime runEndTime;

	@Column(name = "pace")
	private Integer pace;

	@Column(name = "calorie")
	private Integer calorie;

	@Column(name="duration")
	private Integer duration;

	public Long getDuration() {
		if (runStartTime != null && runEndTime != null) {
			return Duration.between(runStartTime, runEndTime).toMillis();
		} else {
			return null;
		}
	}
	public RecordDto toRecordDto() {
		return RecordDto.builder()
				.id(getId())
				.duration(getDuration())
				.gameMode(getGameMode())
				.ranking(getRanking())
				.distance(getDistance())
				.build();
	}

}