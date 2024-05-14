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
    public ResponseEntity<String> sendSms(String to) {

        try {
            boolean result = smsProvider.sendSms(to);
            if (!result) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메세지 전송에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메세지 전송 중 오류가 발생했습니다.");
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메세지 전송에 성공했습니다.");
    }
}
