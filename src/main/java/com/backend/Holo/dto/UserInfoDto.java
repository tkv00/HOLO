package com.backend.Holo.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class UserInfoDto {
    private Long userId;
    private String phoneNumber;
    private String nickName;
    private String city;
    private String dong;
    private Float mannerTemp;

    public UserInfoDto(Long userId, String phoneNumber, String nickName, String city, String dong, Float mannerTemp) {
        this.userId = userId;
        this.phoneNumber = phoneNumber;
        this.nickName = nickName;
        this.city = city;
        this.dong = dong;
        this.mannerTemp = mannerTemp;
    }
}
