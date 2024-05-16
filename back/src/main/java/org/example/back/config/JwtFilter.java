package org.example.back.config;

import java.io.IOException;
import java.util.List;

import org.example.back.db.entity.Member;
import org.example.back.db.enums.ErrorMessage;
import org.example.back.db.repository.MemberRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.redis.repository.BlackListRepository;
import org.example.back.util.JWTUtil;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
public class JwtFilter extends OncePerRequestFilter {

	private final BlackListRepository blackListRepository;
	private final MemberRepository memberRepository;

	private final String secretKey;

	@Override

	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
		FilterChain filterChain) throws ServletException, IOException {

		try{
			final String authorization = request.getHeader(HttpHeaders.AUTHORIZATION);
			log.info("authorization: {}", authorization);

			if (authorization == null) {
				log.info("authorization 없음");
				request.setAttribute("exception", ErrorMessage.TOKEN_NOT_EXIST.getMsg());
				filterChain.doFilter(request,response);
				return;
			}

			// 토큰 없으면 막음
			if (!authorization.startsWith("Bearer ")) {
				log.info("authorization 잘못됨.");
				request.setAttribute("exception", ErrorMessage.UNSUPPORTED_TOKEN.getMsg());
				filterChain.doFilter(request,response);
				return;
			}

			// 토큰 꺼내기

			String token = authorization.split(" ")[1];
			// Token Expired 여부 확인
			if (JWTUtil.validateToken(token, secretKey)&& !request.getRequestURI().equals("/api/auth/reissue")) {
				filterChain.doFilter(request,response);
				return;
			}
			String memberId = JWTUtil.getId(token, secretKey);
			log.info("memberId: {}", memberId);
			if(blackListRepository.existsById(token)){
				log.error("로그아웃한 사용자");
				request.setAttribute("exception", ErrorMessage.ALREADY_LOGOUT.getMsg());
				filterChain.doFilter(request,response);
				return;
			}
			Member member = memberRepository.findById(Long.valueOf(memberId)).orElseThrow(MemberNotFoundException::new);
			UsernamePasswordAuthenticationToken authenticationToken =
				new UsernamePasswordAuthenticationToken(memberId, null, List.of(new SimpleGrantedAuthority("USER")));

			authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
			SecurityContextHolder.getContext().setAuthentication(authenticationToken);
		}catch (JwtException e){
			request.setAttribute("exception", e.getMessage());
		}



		filterChain.doFilter(request,response);
	}
}
