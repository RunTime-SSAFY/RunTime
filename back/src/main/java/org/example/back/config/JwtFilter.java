package org.example.back.config;

import java.io.IOException;
import java.util.List;

import org.example.back.auth.service.AuthService;
import org.example.back.util.JWTUtil;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
public class JwtFilter extends OncePerRequestFilter {

	private final AuthService memberService;

	private final String secretKey;

	@Override

	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
		FilterChain filterChain) throws ServletException, IOException {

		final String authorization = request.getHeader(HttpHeaders.AUTHORIZATION);
		log.info("authorization: {}", authorization);

		// 토큰 없으면 막음
		if (authorization == null || !authorization.startsWith("Bearer ")) {
			log.info("authorization 잘못됨.");
			filterChain.doFilter(request,response);
			return;
		}

		// 토큰 꺼내기

		String token = authorization.split(" ")[1];

		// Token Expired 여부 확인
		if (JWTUtil.isExpired(token, secretKey)&& !request.getRequestURI().equals("/api/auth/reissue")) {
			log.error("토큰 만료되었음.");
			filterChain.doFilter(request,response);
			return;
		}

		String memberId = JWTUtil.getId(token, secretKey);
		log.info("memberId: {}", memberId);

		UsernamePasswordAuthenticationToken authenticationToken =
			new UsernamePasswordAuthenticationToken(memberId, null, List.of(new SimpleGrantedAuthority("USER")));

		authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
		SecurityContextHolder.getContext().setAuthentication(authenticationToken);

		filterChain.doFilter(request,response);
	}
}
