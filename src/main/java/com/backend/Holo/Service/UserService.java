package com.backend.Holo.Service;


import com.backend.Holo.Entity.UserEntity;
import com.backend.Holo.Repository.UserRepository;
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
//    private final DeviceInfoRepository deviceInfoRepository;

    // 로그인
    public boolean login(String PhoneNumber) {
        // 휴대폰 번호를 이용해서 사용자 조회, 만약 사용자가 존재하면 로그인 Success
        UserEntity checkuser = userRepository.findByPhoneNumber(PhoneNumber);
        return checkuser != null;
    }

//    // 자동 로그인
//    public boolean autoLogin(String PhoneNum, String deviceId) {
//        // 휴대폰 번호를 이용해서 사용자 조회, 기기 정보 저장 후 연결
//        UserEntity user = userRepository.findByPhoneNumber(PhoneNum);
//        if (user != null) {
//            DeviceInfo deviceInfo = new DeviceInfo();
//            deviceInfo.setDeviceId(deviceId);
//            deviceInfo.setUser(user);
//            deviceInfoRepository.save(deviceInfo);
//
//            return true;
//        }
//        return false;
//    }
//
//    // 로그아웃
//    public void logout(String deviceId) {
//        // 기기 ID 이용해서 해당 기기 정보 삭제
//        deviceInfoRepository.deleteByDeviceId(deviceId);
//    }

    // 회원 가입
    public Long signup(UserEntity user) {

        if (!smsAuthentication(user)) {
            throw new IllegalStateException("SMS 인증에 실패했습니다.");
        }

        // 이미 존재하는 휴대폰 번호인지 확인
        UserEntity existingUser = userRepository.findByPhoneNumber(user.getPhoneNumber());
        if (existingUser != null) {
            throw new IllegalStateException("이미 존재하는 회원입니다.");
        }

        // 개인 식별번호 생성 및 부여
        String IdentificationNumber = generateIdentificationNumber();
        user.setIdentificationNumber(IdentificationNumber);

        // 회원 저장
        userRepository.save(user);
        return user.getUserId();
    }

    // 회원 전체 조회
    public List<UserEntity> findAllUser() {
        return userRepository.findAll();
    }

    // 개인 식별번호 생성
    private String generateIdentificationNumber() {
        // 랜덤한 문자열을 생성
        String ch = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random rd = new Random();

        for (int i = 0; i < 10; i++) {
            int index = rd.nextInt(ch.length());
            sb.append(ch.charAt(index));
        }
        return sb.toString();
    }

    // SMS 인증
    private boolean smsAuthentication(UserEntity user) {
        // 여기에 SMS 인증 로직 구현하기
        return true;
    }
}
