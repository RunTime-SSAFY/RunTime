package org.example.back.db.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "member")
public class Member {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Long id;

	@Lob
	@Column(name = "role")
	private String role;

	@Column(name = "nickname", length = 30)
	private String nickname;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "character_id", nullable = false)
	private Character character;

	@Column(name = "email", length = 100)
	private String email;

	@Column(name = "age")
	private Integer age;

	@Column(name = "tier_score")
	private Integer tierScore;

	@Column(name = "height")
	private Float height;

	@Column(name = "weight")
	private Float weight;

	@Column(name = "is_deleted")
	private Byte isDeleted;

}