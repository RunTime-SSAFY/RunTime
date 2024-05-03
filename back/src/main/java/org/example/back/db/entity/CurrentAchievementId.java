package org.example.back.db.entity;

import java.io.Serializable;
import java.util.Objects;

import org.hibernate.Hibernate;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Embeddable
public class CurrentAchievementId implements Serializable {
	private static final long serialVersionUID = 4046452830594304344L;
	@Column(name = "member_id", nullable = false)
	private Long memberId;

	@Column(name = "achievement_id", nullable = false)
	private Long achievementId;

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o))
			return false;
		CurrentAchievementId entity = (CurrentAchievementId)o;
		return Objects.equals(this.achievementId, entity.achievementId) &&
			Objects.equals(this.memberId, entity.memberId);
	}

	@Override
	public int hashCode() {
		return Objects.hash(achievementId, memberId);
	}

}