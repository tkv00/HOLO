package HOLO.service;

import org.springframework.http.ResponseEntity;

public interface SMSService {

    ResponseEntity<String> sendSms(String phoneNumber);
    ResponseEntity<String> checkVerificationCode(String phoneNumber, String verificationCode);
}
