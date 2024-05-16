package org.example.back.util;

import java.security.SignatureException;
import java.util.Date;

import org.example.back.db.enums.ErrorMessage;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
public class JWTUtil {

	private static final long REFRESH_TOKEN_EXPIRE_TIME = 1000 * 60 * 60 * 24 * 4;  // 4일

	public static String getId(String token, String secretKey) {
		return Jwts.parser()
			.setSigningKey(secretKey)
			.build()
			.parseClaimsJws(token)
			.getPayload().getIssuer();

	}

	public static boolean validateToken(String token, String secretKey) {

		try {
			return Jwts.parser()
				.setSigningKey(secretKey)
				.build()
				.parseClaimsJws(token)
				.getBody()
				.getExpiration()
				.before(new Date());
		} catch (MalformedJwtException e) {
			log.info("MalformedJwtException");
			throw new JwtException(ErrorMessage.UNSUPPORTED_TOKEN.getMsg());
		} catch (ExpiredJwtException e) {
			log.info("ExpiredJwtException");
			throw new JwtException(ErrorMessage.EXPIRED_TOKEN.getMsg());
		} catch (IllegalArgumentException e) {
			log.info("IllegalArgumentException");
			throw new JwtException(ErrorMessage.UNKNOWN_ERROR.getMsg());
		}

	}

	public static String createJwt(Long memberId, String secretKey, Long expiredMs) {

		return Jwts.builder()
			// .setSubject(ACCESS_TOKEN_SUBJECT)
			.issuer(String.valueOf(memberId))//사용자 정보 저장하는 Claim
			.issuedAt(new Date(System.currentTimeMillis())) //인증 날짜
			.expiration(new Date(System.currentTimeMillis() + expiredMs)) //만료
			.signWith(SignatureAlgorithm.HS512, secretKey) // 인증 키 (왜 Deprecated죠 또?)
			.compact();
	}

	public static String createRefreshToken(String secretKey) {
		long now = (new Date()).getTime();
		return Jwts.builder()
			.expiration(new Date(now + REFRESH_TOKEN_EXPIRE_TIME))
			.signWith(SignatureAlgorithm.HS512, secretKey)
			.compact();
	}

	public static Long getExpiration(String token, String secretKey) {
		long expiration = Jwts.parser()
			.setSigningKey(secretKey)
			.build()
			.parseClaimsJws(token)
			.getBody()
			.getExpiration().getTime();
		Long now = new Date().getTime();
		return expiration - now;
	}
}