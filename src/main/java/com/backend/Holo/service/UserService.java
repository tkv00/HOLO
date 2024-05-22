package com.backend.Holo.service;


import com.backend.Holo.entity.UserEntity;
import com.backend.Holo.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Random;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    // 로그인
    public boolean login(String phoneNumber) {
        UserEntity checkUser = userRepository.findByPhoneNumber(phoneNumber);
        return checkUser != null;
    }

    // 회원 가입
    public UserEntity signup(UserEntity user) {
        UserEntity existingUser = userRepository.findByPhoneNumber(user.getPhoneNumber());
        if (existingUser != null) {
            throw new IllegalStateException("이미 존재하는 회원입니다.");
        }

        String identificationNumber = generateIdentificationNumber();
        user.setIdentificationNumber(identificationNumber);

        userRepository.save(user);
        return user;
    }

    public List<UserEntity> findAllUser() {
        return userRepository.findAll();
    }

    private String generateIdentificationNumber() {
        String ch = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random rd = new Random();

        for (int i = 0; i < 10; i++) {
            int index = rd.nextInt(ch.length());
            sb.append(ch.charAt(index));
        }
        return sb.toString();
    }

    public boolean userExists(String phoneNumber) {
        UserEntity user = userRepository.findByPhoneNumber(phoneNumber);
        return user != null;
    }
}
