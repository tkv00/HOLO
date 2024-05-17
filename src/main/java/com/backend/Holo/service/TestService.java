package com.backend.Holo.service;

import org.springframework.http.ResponseEntity;

public interface TestService {

    ResponseEntity<String> sendSms(String phoneNumber);
    ResponseEntity<String> checkVerificationCode(String phoneNumber, String verificationCode);
}
