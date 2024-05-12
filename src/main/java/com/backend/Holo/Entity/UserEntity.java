package com.backend.Holo.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

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
    private Date birthDate;

    @NotNull
    @NotEmpty(message = "닉네임 기입은 필수입니다.")
    private String nickName;

    @Email
    @NotNull
    @NotEmpty(message = "이메일 주소 기입은 필수입니다.")
    private String email;

    @Column(unique = true)
    private String identificationNumber;

    private String imageURL;

    private float mannerTemp;

    private LocalDateTime created;

    private LocalDateTime updated;

    private String status;

}
