package com.backend.Holo.Controller;

import com.backend.Holo.Entity.UserEntity;
import com.backend.Holo.Repository.UserRepository;
import com.backend.Holo.Service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class UserController {

    private final UserService userService;
    private final UserRepository userRepository;

    // 회원가입 api
    @PostMapping("/signup")
    public ResponseEntity<String> signup(@Validated @RequestBody UserEntity userEntity, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("사용할 수 없는 유저 데이터");
        }
        try {
            Long userId = userService.signup(userEntity);
            return ResponseEntity.status(HttpStatus.CREATED).body("회원가입에 성공하였습니다! 회원님의 고유 번호는 " + userEntity.getIdentificationNumber() + "입니다.");
        } catch (IllegalStateException e) {
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
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인에 실패하였습니다.");
        }
    }

}
