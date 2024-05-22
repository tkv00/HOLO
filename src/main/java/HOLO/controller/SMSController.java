package HOLO.controller;

import HOLO.service.SMSService;
import HOLO.service.UserService;
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
    private final UserService userService;

    @PostMapping("/send")
    public ResponseEntity<String> sendSms(@RequestBody Map<String, String> requestBody,
                                          @RequestParam String type) {
        String phoneNumber = requestBody.get("phoneNumber");

        if ("signup".equals(type)) {
            if (userService.userExists(phoneNumber)) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이미 존재하는 회원입니다.");
            }
        } else if ("login".equals(type)) {
            if (!userService.userExists(phoneNumber)) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("먼저 회원가입을 하시길 바랍니다.");
            }
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("잘못된 요청 타입입니다.");
        }

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