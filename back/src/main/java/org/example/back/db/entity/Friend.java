package org.example.back.db.entity;

import org.example.back.common.BaseEntity;
import org.example.back.db.enums.FriendStatusType;

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
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Entity
@Table(name = "friend")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Friend extends BaseEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "requester_id", nullable = false)
	private Member requester;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "addressee_id", nullable = false)
	private Member addressee;

	@Lob
	@Column(name = "status")
	@Enumerated(EnumType.STRING)
	private FriendStatusType status;

	public void updateStatus(FriendStatusType status) {
		this.status = status;
	}

	public void updateRequesterAndAddressee(Member requester, Member addressee) {
		this.requester = requester;
		this.addressee=  addressee;
	}

}