package org.example.back.db.entity;

import java.util.LinkedHashSet;
import java.util.Set;

import org.example.back.common.BaseEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "`character`")
public class Character extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "name", length = 30)
    private String name;

    @Lob
    @Column(name = "detail")
    private String detail;

    @Lob
    @Column(name = "img_url")
    private String imgUrl;

    @OneToMany(mappedBy = "character")
    private Set<Achievement> achievements = new LinkedHashSet<>();

}