package com.backend.Holo.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Entity
@Getter @Setter
public class UserEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long id;

    @NotNull
    @NotEmpty(message = "휴대폰 번호 기입은 필수입니다.")
    private String u_phone;

    @NotNull
    @NotEmpty(message = "실명 기입은 필수입니다.")
    private String u_name;

    @NotNull(message = "생년월일 기입은 필수입니다.")
    private Date u_birthdate;

    @NotNull
    @NotEmpty(message = "닉네임 기입은 필수입니다.")
    private String u_username;

    @Email
    @NotNull
    @NotEmpty(message = "이메일 주소 기입은 필수입니다.")
    private String u_email;

    @Column(unique = true)
    private String personalIdentificationNumber;
}
