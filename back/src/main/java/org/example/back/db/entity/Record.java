package org.example.back.db.entity;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.example.back.common.BaseEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import org.example.back.db.enums.GameMode;

@Getter
@Setter
@Entity
@Table(name = "record")
public class Record extends BaseEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "member_id", nullable = false)
	private Member member;

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

	@Column(name = "avg_speed")
	private Float avgSpeed;

	@Column(name = "pace")
	private Integer pace;

	@Column(name = "calorie")
	private Integer calorie;

	public Long getDuration() {
		if (runStartTime != null && runEndTime != null) {
			return Duration.between(runStartTime, runEndTime).toMillis();
		} else {
			return null;
		}
	}

}