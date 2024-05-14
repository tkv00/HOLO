package com.backend.Holo.service;

import org.springframework.http.ResponseEntity;

public interface TestService {

    ResponseEntity<String> sendSms(String to);
}
