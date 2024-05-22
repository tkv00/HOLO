package com.backend.Holo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter @Setter
@Table(name = "user")
public class UserEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userId")
    private Long userId;

    @NotNull
    @NotEmpty(message = "휴대폰 번호 기입은 필수입니다.")
    private String phoneNumber;

    @NotNull
    @NotEmpty(message = "실명 기입은 필수입니다.")
    private String userName;

    @NotNull(message = "생년월일 기입은 필수입니다.")
    private String birthDate;

    @NotNull
    @NotEmpty(message = "닉네임 기입은 필수입니다.")
    private String nickName;

    private String verificationCode;

    @Column(unique = true)
    private String identificationNumber;

    @Column(columnDefinition = "TEXT")
    private String imageURL;

    @Column(columnDefinition = "FLOAT(3,1) DEFAULT '36.5'")
    private Float mannerTemp = 36.5f;

    @Column(columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", updatable = false)
    private LocalDateTime created;

    @Column(columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    private LocalDateTime updated;

    @Column(length = 20, columnDefinition = "VARCHAR(20) DEFAULT 'Active'")
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
