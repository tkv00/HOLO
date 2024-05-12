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

    public UserEntity toEntity() {

        UserEntity userEntity = new UserEntity();
        userEntity.setPhoneNumber(this.phoneNumber);
        userEntity.setUserName(this.userName);
        userEntity.setBirthDate(this.birthDate);
        userEntity.setNickName(this.nickName);
        userEntity.setEmail(this.email);
        userEntity.setIdentificationNumber(this.identificationNumber);

        return userEntity;
    }
}
