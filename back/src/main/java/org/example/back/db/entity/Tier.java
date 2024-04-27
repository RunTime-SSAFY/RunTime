package org.example.back.db.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "tier")
public class Tier {
	@Id
	@Column(name = "id", nullable = false)
	private Long id;

	@Column(name = "name", length = 30)
	private String name;

	@Column(name = "score_min")
	private Integer scoreMin;

	@Column(name = "score_max")
	private Integer scoreMax;

	@Lob
	@Column(name = "img_url")
	private String imgUrl;

}