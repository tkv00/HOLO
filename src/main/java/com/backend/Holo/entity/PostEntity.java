package com.backend.Holo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter @Setter
@Table(name = "post")
public class PostEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long postId;

    // @NotNull
    private Long userId;

    private Long addressId; // 동, 읍, 면

    @NotNull
    @NotEmpty(message = "제목은 필수입니다.")
    @Column(name = "title", length = 100)
    private String title;

    // @NotNull
    private Long categoryId;

    @ManyToOne
    @JoinColumn(name = "categoryId", referencedColumnName = "categoryId", insertable = false, updatable = false)
    private CategoryEntity category;


    @Column(name = "cost", columnDefinition = "int DEFAULT '0'")
    private Integer cost = 0;

    @Column(name = "chatCount", columnDefinition = "int DEFAULT '0'")
    private Integer chatCount = 0;

    @Column(name = "viewCount", columnDefinition = "int DEFAULT '0'")
    private Integer viewCount = 0;

    @Column(name = "contents", columnDefinition = "TEXT")
    private String contents;

    @Column(name = "toGive", length = 50, columnDefinition = "varchar(50) DEFAULT '없음'")
    private String toGive = "없음";

    @Column(name = "wishToExchange", length = 50, columnDefinition = "varchar(50) DEFAULT '없음'")
    private String wishToExchange = "없음";

    @Column(name = "wishToExchangeCity", length = 50, columnDefinition = "varchar(50) DEFAULT '없음'")
    private String wishToExchangeCity = "없음";

    @Column(name = "created", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", updatable = false)
    private LocalDateTime created;

    @Column(name = "updated", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
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
}
