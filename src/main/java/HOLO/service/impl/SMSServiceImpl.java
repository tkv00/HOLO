package HOLO.service.impl;

import HOLO.provider.SmsProvider;
import HOLO.service.SMSService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;
import java.util.concurrent.*;

@Service
@RequiredArgsConstructor
public class SMSServiceImpl implements SMSService {

    private final SmsProvider smsProvider;
    private final ConcurrentHashMap<String, String> verificationCodes = new ConcurrentHashMap<>();
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private final ConcurrentHashMap<String, ScheduledFuture<?>> scheduledTasks = new ConcurrentHashMap<>();

    private static final SecureRandom secureRandom = new SecureRandom();
    @Override
    public ResponseEntity<String> sendSms(String phoneNumber) {
        String verificationCode = generateVerificationCode();
        String messageText = "[Holo] 본인 확인 인증번호입니다.\n" + verificationCode;

        try {
            boolean result = smsProvider.sendSms(phoneNumber, messageText);
            if (!result) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
            }

            ScheduledFuture<?> existingTask = scheduledTasks.remove(phoneNumber);
            if (existingTask != null) {
                existingTask.cancel(true);
            }

            verificationCodes.put(phoneNumber, verificationCode);

            ScheduledFuture<?> scheduledTask = scheduler.schedule(() -> {
                verificationCodes.remove(phoneNumber);
                scheduledTasks.remove(phoneNumber);
            }, 3, TimeUnit.MINUTES);

            scheduledTasks.put(phoneNumber, scheduledTask);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
        return ResponseEntity.ok().build();
    }

    @Override
    public ResponseEntity<String> checkVerificationCode(String phoneNumber, String verificationCode) {
        String storedCode = verificationCodes.get(phoneNumber);

        if (storedCode != null && storedCode.equals(verificationCode)) {
            verificationCodes.remove(phoneNumber);
            ScheduledFuture<?> scheduledTask = scheduledTasks.remove(phoneNumber);
            if (scheduledTask != null) {
                scheduledTask.cancel(true);
            }
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }

    private String generateVerificationCode() {
        StringBuilder code = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            code.append(secureRandom.nextInt(10));
        }
        return code.toString();
    }
}
