package com.example.demo;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class web_config implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		registry.addResourceHandler("/final/**").addResourceLocations("file:///"+NaverInform.path);
		// file: ~~ 경로에 있는걸(이미지 등) 호출하는 URL은 8092/naverai/~~~ 이다.
	
	}
	
	// 외부 경로에 저장된 파일 불러오기
	
	

}
