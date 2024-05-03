package org.example.back.db.entity;

import org.example.back.common.BaseEntity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "achievement")
public class Achievement extends BaseEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Long id;

	@ManyToOne
	@JoinColumn(name = "achievement_type_id", nullable = false)
	private AchievementType achievementType;

	@Column(name = "name", length = 50)
	private String name;

	@Lob
	@Column(name = "detail")
	private String detail;


	@Column(name = "grade")
	private Integer grade;

	@Column(name = "goal")
	private Float goal;

	@OneToOne(mappedBy = "achievement", cascade = CascadeType.ALL, fetch = FetchType.LAZY, optional = false)
	private Character character;

}