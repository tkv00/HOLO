package HOLO.controller;

import HOLO.service.SMSService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
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

        if (phoneNumber == null || phoneNumber.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("전화번호가 유효하지 않습니다.");
        }

        ResponseEntity<String> response = smsService.sendSms(phoneNumber);
        if (response.getStatusCode() == HttpStatus.OK) {
            return ResponseEntity.ok("SMS 전송 성공");
        } else {
            return ResponseEntity.status(response.getStatusCode()).body("메세지 전송에 실패했습니다.");
        }
    }

    @PostMapping("/check")
    public ResponseEntity<String> checkCode(@RequestBody Map<String, String> requestBody) {
        String phoneNumber = requestBody.get("phoneNumber");
        String verificationCode = requestBody.get("verificationCode");

        if (phoneNumber == null || verificationCode == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("전화번호 또는 인증 코드가 유효하지 않습니다.");
        }

        ResponseEntity<String> response = smsService.checkVerificationCode(phoneNumber, verificationCode);
        if (response.getStatusCode() == HttpStatus.OK) {
            return ResponseEntity.ok("인증에 성공했습니다.");
        } else {
            return ResponseEntity.status(response.getStatusCode()).body("인증에 실패했습니다.");
        }
    }
}