package org.example.back.config;

import static org.springframework.security.config.Customizer.*;

import org.example.back.member.service.MemberService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.LogoutConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import lombok.RequiredArgsConstructor;

@EnableWebSecurity
@Configuration
@RequiredArgsConstructor
public class SecurityConfig {


	private final MemberService memberService;

	@Value("${jwt.secret}")
	private String secretKey;
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
		return httpSecurity
			.httpBasic(AbstractHttpConfigurer::disable) //기본 http 보안 설정 사용 안함
			.csrf(AbstractHttpConfigurer::disable) //csrf 사용 안함
			.cors(AbstractHttpConfigurer::disable) //cors 정책 비활성화
			.authorizeHttpRequests(request->{
				request.requestMatchers("/api/members/login", "/api/members/join").permitAll()//login, join은 전부 허용
					.requestMatchers(HttpMethod.POST,"/api/tests");
			})
			.sessionManagement(
				sessionManagement->sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS) //세션 stateless -> 세션 안 쓴다는 뜻
			)
			.addFilterBefore(new JwtFilter(memberService, secretKey), UsernamePasswordAuthenticationFilter.class)
			.build();
	}
}
