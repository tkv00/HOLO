package com.backend.Holo.service.impl;

import com.backend.Holo.provider.SmsProvider;
import com.backend.Holo.service.TestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.concurrent.*;

@Service
@RequiredArgsConstructor
public class TestServiceImpl implements TestService {

    private final SmsProvider smsProvider;
    private final ConcurrentHashMap<String, String> verificationCodes = new ConcurrentHashMap<>();
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private final ConcurrentHashMap<String, ScheduledFuture<?>> scheduledTasks = new ConcurrentHashMap<>();

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

            // 기존의 인증번호와 스케줄러가 있다면 취소하고 제거
            ScheduledFuture<?> existingTask = scheduledTasks.remove(phoneNumber);
            if (existingTask != null) {
                existingTask.cancel(true);
            }

            // 인증번호 저장
            verificationCodes.put(phoneNumber, verificationCode);

            // 3분 후에 인증번호 제거
            ScheduledFuture<?> scheduledTask = scheduler.schedule(() -> {
                verificationCodes.remove(phoneNumber);
                scheduledTasks.remove(phoneNumber);
            }, 3, TimeUnit.MINUTES);

            // 스케줄러 작업 저장
            scheduledTasks.put(phoneNumber, scheduledTask);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메세지 전송 중 오류가 발생했습니다.");
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메세지 전송에 성공했습니다.");
    }

    @Override
    public ResponseEntity<String> checkVerificationCode(String phoneNumber, String verificationCode) {
        String storedCode = verificationCodes.get(phoneNumber);

        if (storedCode != null && storedCode.equals(verificationCode)) {
            // 인증번호 일치 시 맵에서 제거하고 스케줄된 작업도 취소
            verificationCodes.remove(phoneNumber);
            ScheduledFuture<?> scheduledTask = scheduledTasks.remove(phoneNumber);
            if (scheduledTask != null) {
                scheduledTask.cancel(true);
            }
            return ResponseEntity.ok("인증에 성공했습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("인증번호가 일치하지 않습니다.");
        }
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
