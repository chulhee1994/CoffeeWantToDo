package com.myspring.team.member.service;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    // 아이디 발송 메소드
    public void sendIdEmail(String recipientEmail, String userName, String userId) {
        // 이메일 본문
        String subject = "아이디 찾기 결과";
        String body = "안녕하세요, " + userName + "님\n\n"
                    + "요청하신 아이디는 " + userId + "입니다.\n\n"
                    + "이메일을 통해 아이디를 보내드렸습니다.";

        // SimpleMailMessage 객체 생성
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(recipientEmail);  // 수신자 이메일
        message.setFrom("sy43241@naver.com");  // 발신자 이메일
        message.setSubject(subject);  // 제목
        message.setText(body);  // 본문

        // 이메일 발송
        mailSender.send(message);
    }
    
    public void sendAuthEmail(String toEmail, String authCode) throws MessagingException {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);  // 수신자 이메일
        message.setFrom("sy43241@naver.com");  // 송신자 이메일
        message.setSubject("비밀번호 찾기 인증번호");  // 이메일 제목
        message.setText("안녕하세요, \n\n"
                        + "요청하신 인증번호는 " + authCode + "입니다.\n\n"
                        + "이메일을 통해 인증번호를 보내드렸습니다.");

        mailSender.send(message);  // 이메일 발송
    }
    
    public void sendAuthEmail2(String Email, String sendCode) throws MessagingException {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(Email);  // 수신자 이메일
        message.setFrom("sy43241@naver.com");  // 송신자 이메일
        message.setSubject("본인확인 인증번호");  // 이메일 제목
        message.setText("안녕하세요, \n\n"
                        + "요청하신 인증번호는 " + sendCode + "입니다.\n\n"
                        + "이메일을 통해 인증번호를 보내드렸습니다.");

        mailSender.send(message);  // 이메일 발송
    }
    
}

