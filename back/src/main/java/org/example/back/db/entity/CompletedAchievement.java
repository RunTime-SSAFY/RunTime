package org.example.back.db.entity;

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
@Table(name = "completed_achievement")
public class CompletedAchievement {
	@EmbeddedId
	private CompletedAchievementId id;

	@MapsId("achievementId")
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "achievement_id", nullable = false)
	private Achievement achievement;

	@Column(name = "is_received")
	private Byte isReceived;

}