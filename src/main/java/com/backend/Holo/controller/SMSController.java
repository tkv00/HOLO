package com.backend.Holo.controller;

import com.backend.Holo.service.SMSService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/message")
public class SMSController {

    private final SMSService smsService;

    @PostMapping("/send")
    public ResponseEntity<String> sendSms(@RequestBody Map<String, String> requestBody) {
        String phoneNumber = requestBody.get("phoneNumber");
        ResponseEntity<String> response = smsService.sendSms(phoneNumber);
        return response;
    }

    @PostMapping("/check")
    public ResponseEntity<String> checkCode(@RequestBody Map<String, String> requestBody) {
        String phoneNumber = requestBody.get("phoneNumber");
        String verificationCode = requestBody.get("verificationCode");
        ResponseEntity<String> response = smsService.checkVerificationCode(phoneNumber, verificationCode);
        return response;
    }
}
