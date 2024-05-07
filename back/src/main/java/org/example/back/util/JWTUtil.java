package org.example.back.util;

import java.security.Key;
import java.util.Date;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JWTUtil {

	private static final long REFRESH_TOKEN_EXPIRE_TIME = 1000 * 60 * 60 * 24*4;  // 4일
	public static String getId(String token, String secretKey) {
		return Jwts.parser()
			.setSigningKey(secretKey)
			.build()
			.parseClaimsJws(token)
			.getPayload().getIssuer();

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

	public static String createJwt(Long memberId, String secretKey, Long expiredMs){

		return Jwts.builder()
			// .setSubject(ACCESS_TOKEN_SUBJECT)
			.issuer(String.valueOf(memberId))//사용자 정보 저장하는 Claim
			.issuedAt(new Date(System.currentTimeMillis())) //인증 날짜
			.expiration(new Date(System.currentTimeMillis() + expiredMs)) //만료
			.signWith(SignatureAlgorithm.HS512, secretKey) // 인증 키 (왜 Deprecated죠 또?)
			.compact();
	}

	public static String createRefreshToken(String secretKey){
		long now = (new Date()).getTime();
		return Jwts.builder()
			.expiration(new Date(now + REFRESH_TOKEN_EXPIRE_TIME))
			.signWith(SignatureAlgorithm.HS512, secretKey)
			.compact();
	}
}