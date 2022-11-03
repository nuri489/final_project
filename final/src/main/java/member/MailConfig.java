package member;

import java.util.Properties;

import org.springframework.boot.autoconfigure.mail.MailProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {
	
    @Bean
    public JavaMailSender javaMailService() {
        JavaMailSenderImpl sender = new JavaMailSenderImpl();

        sender.setHost("smtp.naver.com"); // 메일 도메인 서버 주소
        sender.setUsername("nuri489"); // 메일 유저 이름
        sender.setPassword("7568suchadoge!"); // 메일 패스워드

        sender.setPort(465); // 메일 인증서버 포트

        sender.setJavaMailProperties(getMailProperties()); // 메일 인증서버 정보 가져오기

        return sender;
    }
    
    private Properties getMailProperties() {
        Properties properties = new Properties();
        properties.setProperty("mail.transport.protocol", "smtp"); // 프로토콜 설정
        properties.setProperty("mail.smtp.auth", "true"); // smtp 인증
        properties.setProperty("mail.smtp.starttls.enable", "true"); // smtp strattles 사용
        properties.setProperty("mail.debug", "true"); // 디버그 사용
        properties.setProperty("mail.smtp.ssl.trust","smtp.naver.com"); // ssl 인증 서버는 smtp.naver.com
        properties.setProperty("mail.smtp.ssl.enable","true"); // ssl 사용
        return properties;
    }

}
