package org.example.back.db.entity;

import java.io.Serializable;
import java.util.Objects;

import org.hibernate.Hibernate;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Embeddable
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CurrentAchievementId implements Serializable {
	private static final long serialVersionUID = 4046452830594304344L;
	@Column(name = "member_id", nullable = false)
	private Long memberId;

	@Column(name = "achievement_type_id", nullable = false)
	private Long achievementTypeId;

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o))
			return false;
		CurrentAchievementId entity = (CurrentAchievementId)o;
		return Objects.equals(this.achievementTypeId, entity.achievementTypeId) &&
			Objects.equals(this.memberId, entity.memberId);
	}

	@Override
	public int hashCode() {
		return Objects.hash(achievementTypeId, memberId);
	}

}