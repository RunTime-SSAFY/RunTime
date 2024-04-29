package org.example.back.util;

import java.util.Date;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JWTUtil {

	private static final long REFRESH_TOKEN_EXPIRE_TIME = 1000 * 60 * 60 * 24 * 7;  // 7일
	public static String getEmail(String token, String secretKey) {
		return Jwts.parser()
			.setSigningKey(secretKey)
			.build()
			.parseClaimsJws(token)
			.getBody().get("email", String.class);

	}

	public static boolean isExpired(String token, String secretKey) {


		return Jwts.parser()
			.setSigningKey(secretKey)
			.build()
			.parseClaimsJws(token)
			.getBody()
			.getExpiration()
			.before(new Date());
	}

	public static String createJwt(String email, String secretKey, Long expiredMs){

		return Jwts.builder()
			// .setSubject(ACCESS_TOKEN_SUBJECT)
			.claim("email", email) //사용자 정보 저장하는 Claim
			.issuedAt(new Date(System.currentTimeMillis())) //인증 날짜
			.expiration(new Date(System.currentTimeMillis() + expiredMs)) //만료
			.signWith(SignatureAlgorithm.HS256, secretKey) // 인증 키 (왜 Deprecated죠 또?)
			.compact();
	}

	public static String createRefreshToken(String secretKey){
		long now = (new Date()).getTime();
		return Jwts.builder()
			.setExpiration(new Date(now + REFRESH_TOKEN_EXPIRE_TIME))
			.signWith(SignatureAlgorithm.HS512, secretKey)
			.compact();
	}
}