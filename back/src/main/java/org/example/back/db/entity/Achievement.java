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

	@Column(name = "class")
	private Integer classField;

	@Column(name = "name", length = 50)
	private String name;

	@Lob
	@Column(name = "detail")
	private String detail;

	@Column(name = "criteria", length = 50)
	private String criteria;

	@Column(name = "grade")
	private Integer grade;

	@Column(name = "goal")
	private Float goal;

	@OneToOne(mappedBy = "achievements", cascade = CascadeType.ALL, fetch = FetchType.LAZY, optional = false)
	private Character character;

	@Column(name = "is_final")
	private Byte isFinal;

}