package com.backend.Holo.Controller;

import com.backend.Holo.Entity.UserEntity;
import jakarta.persistence.Column;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter @Setter
public class UserForm {

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

    public UserEntity toEntity() {
        UserEntity userEntity = new UserEntity();
        userEntity.setU_phone(this.u_phone);
        userEntity.setU_name(this.u_name);
        userEntity.setU_birthdate(this.u_birthdate);
        userEntity.setU_username(this.u_username);
        userEntity.setU_email(this.u_email);
        userEntity.setPersonalIdentificationNumber(this.personalIdentificationNumber);

        return userEntity;
    }
}
