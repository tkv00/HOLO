package com.backend.Holo.controller;

import com.backend.Holo.service.TestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequiredArgsConstructor
@RequestMapping("/test")
public class TestController {

    private final TestService testService;

    @GetMapping("/send-sms/{to}")
    public ResponseEntity<String> sendSms(@PathVariable("to") String to) {
        ResponseEntity<String> response = testService.sendSms(to);
        return response;
    }

}
