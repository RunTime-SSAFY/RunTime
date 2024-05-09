package org.example.back.db.entity;

import org.example.back.common.BaseEntity;
import org.example.back.db.enums.RoleType;
import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PostLoad;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Table(name = "member")
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Member extends BaseEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Long id;

	@Column(name="fcm_token")
	private String fcmToken;

	@Lob
	@Column(name = "role")
	@Enumerated(EnumType.STRING)
	private RoleType role;

	@Column(name = "nickname", length = 30)
	private String nickname;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "character_id", nullable = false)
	private Character character;

	@Column(name = "email", length = 100,unique = true)
	private String email;

	@Column(name = "tier_score")
	private Integer tierScore;

	@Column(name = "weight")
	private Float weight;

	@Column(name = "is_deleted")
	private Byte isDeleted;

	@Column(name = "consecutive_games")
	@ColumnDefault("0")
	private Integer consecutiveGames;


	public void updateNickname(String nickname) {
		this.nickname = nickname;
	}

	public void updateWeight(float weight) {
		this.weight = weight;
	}

	public void updateTierScore(int score) { this.tierScore = score; }

	public void updateConsecutive(int consecutive) { this.consecutiveGames = consecutive; }

	public void updateCharacter(Character character) { this.character = character; }

	public void updateFcmToken(String fcmToken) {
		this.fcmToken = fcmToken;
	}
}