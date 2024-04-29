package org.example.back.util;

import java.util.Date;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JWTUtil {

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

	// public static String createRefreshToken(){
	// 	Date now = new Date();
	// 	return Jwts.builder();
	// }
}