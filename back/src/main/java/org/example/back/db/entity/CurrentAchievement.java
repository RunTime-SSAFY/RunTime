package org.example.back.db.entity;

import org.example.back.common.BaseEntity;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.DynamicInsert;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@DynamicInsert
@Table(name = "current_achievement")
public class CurrentAchievement extends BaseEntity {
	@EmbeddedId
	private CurrentAchievementId id;

	@MapsId("memberId")
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "member_id", nullable = false)
	private Member member;

	@MapsId("achievementTypeId")
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "achievement_type_id", nullable = false)
	private AchievementType achievementType;

	@Column(name="current_grade")
	@ColumnDefault("1")
	private Integer currentGrade;

	@Column(name="progress")
	@ColumnDefault("0.0")
	private Float progress;

	@Column(name = "is_received")
	@ColumnDefault("0")
	private Boolean isReceived;

	public void updateProgress(Float progress) {
		this.progress = progress;
	}

	public void markReceived(){this.isReceived = true;}
	public void toNextGrade(){
		this.currentGrade++;
	}
}