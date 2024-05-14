package com.backend.Holo.controller;

import com.backend.Holo.entity.UserEntity;
import com.backend.Holo.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class UserController {

    private final UserService userService;
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    // 회원가입 api
    @PostMapping("/signup")
    public ResponseEntity<String> signup(@Validated @RequestBody UserEntity userEntity,
                                         @RequestParam String verificationCode,
                                         BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            logger.error("유효하지 않은 사용자 데이터가 전송되었습니다: {}", bindingResult.getAllErrors());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("사용할 수 없는 유저 데이터 응기잇");
        }
        try {
            Long userId = userService.signup(userEntity, verificationCode);
            return ResponseEntity.status(HttpStatus.CREATED).body("회원가입에 성공하였습니다! 회원님의 고유 번호는 " + userId + "입니다.");
        } catch (IllegalStateException e) {
            logger.error("회원가입 중 오류 발생: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    // 로그인 엔드포인트
    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody Map<String, String> requestBody) {
        String phoneNumber = requestBody.get("phoneNumber");

        boolean success = userService.login(phoneNumber);

        if (success) {
            return ResponseEntity.ok("로그인에 성공하였습니다.");
        } else {
            logger.warn("로그인 실패: 전달된 전화번호 - {}", phoneNumber);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인에 실패하였습니다.");
        }
    }
}

