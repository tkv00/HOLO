package com.backend.Holo.controller;

import com.backend.Holo.service.TestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


@RestController
@RequiredArgsConstructor
@RequestMapping("/message")
public class TestController {

    private final TestService testService;

    @PostMapping("/check")
    public ResponseEntity<String> sendSms(@RequestBody Map<String, String> requestBody) {
        String phoneNumber = requestBody.get("phoneNumber");
        ResponseEntity<String> response = testService.sendSms(phoneNumber);
        return response;
    }

}
