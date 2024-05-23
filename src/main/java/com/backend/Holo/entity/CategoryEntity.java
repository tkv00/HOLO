package com.backend.Holo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter @Setter
@Table(name = "category")
public class CategoryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long categoryId;

    @Column(name = "category", length = 20, nullable = false)
    private String category;

    @Column(name = "categoryType", length = 20)
    private String categoryType;

    @Column(name = "categoryimage", columnDefinition = "TEXT")
    private String categoryimage;

    @Column(name = "created", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", updatable = false)
    private LocalDateTime created;

    @Column(name = "updated", columnDefinition
            = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    private LocalDateTime updated;

    @Column(name = "status", length = 20, columnDefinition = "varchar(20) DEFAULT 'Active'")
    private String status = "Active";

    @PrePersist
    protected void onCreate() {
        if (created == null) {
            created = LocalDateTime.now();
        }
        if (updated == null) {
            updated = LocalDateTime.now();
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updated = LocalDateTime.now();
    }

    @OneToMany(mappedBy = "category")
    @JsonIgnore
    private List<PostEntity> posts;

}
