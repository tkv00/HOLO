package com.backend.Holo.service.impl;

import com.backend.Holo.provider.SmsProvider;
import com.backend.Holo.service.TestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TestServiceImpl implements TestService {

    private final SmsProvider smsProvider;

    @Override
    public ResponseEntity<String> sendSms(String phoneNumber) {

        // SMS 인증번호 생성 (임시로 6자리의 랜덤 숫자 문자열 생성)
        String verificationCode = generateVerificationCode();

        // SMS 메시지 내용 설정
        String messageText = "[Holo] 본인 확인 인증번호입니다.\n" + verificationCode;

        try {
            boolean result = smsProvider.sendSms(phoneNumber, messageText);
            if (!result) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메세지 전송에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메세지 전송 중 오류가 발생했습니다.");
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메세지 전송에 성공했습니다.");
    }

    private String generateVerificationCode() {
        // 임시로 6자리의 랜덤 숫자 문자열 생성
        StringBuilder code = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            code.append((int) (Math.random() * 10));
        }
        return code.toString();
    }
}
