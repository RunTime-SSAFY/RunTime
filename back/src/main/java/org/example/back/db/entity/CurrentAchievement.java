package org.example.back.db.entity;

import org.example.back.common.BaseEntity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "current_achievement")
public class CurrentAchievement extends BaseEntity {
	@EmbeddedId
	private CurrentAchievementId id;

	@MapsId("memberId")
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "member_id", nullable = false)
	private Member member;

	@MapsId("achievementId")
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "achievement_type_id", nullable = false)
	private AchievementType achievementType;

	@Column(name="current_grade")
	private Integer currentGrade;

	@Column(name="progress")
	private Float progress;

	@Column(name = "is_received")
	private Boolean isReceived;

}