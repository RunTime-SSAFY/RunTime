package org.example.back.db.entity;

import org.example.back.common.BaseEntity;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UnlockedChracter extends BaseEntity {

	@Id
	@EmbeddedId
	private UnlockedCharacterId id;

	private Boolean isCheck;
}
