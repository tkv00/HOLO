package com.backend.Holo.provider;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class SmsProvider {
    private final DefaultMessageService messageService;

    @Value("${coolsms.from_number}") String FROM;

    public SmsProvider(@Value("${coolsms.api_key}") String API_KEY,
                       @Value("${coolsms.api_secret}") String API_SECRET_KEY,
                       @Value("${coolsms.domain}") String DOMAIN) {
        this.messageService = NurigoApp.INSTANCE.initialize(API_KEY, API_SECRET_KEY, DOMAIN);
    }

    public boolean sendSms(String to, String messageText) {
        Message message = new Message();
        message.setFrom(FROM);
        message.setTo(to);
        message.setText(messageText);

        SingleMessageSentResponse response = messageService.sendOne(new SingleMessageSendingRequest(message));

        String statusCode = response.getStatusCode();
        boolean result = statusCode.equals("2000");

        return result;
    }
}
