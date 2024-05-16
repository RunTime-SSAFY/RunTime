package org.example.back.config;

import java.io.IOException;

import org.example.back.db.enums.ErrorMessage;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
		AuthenticationException authException) throws IOException, ServletException {
		String exception = (String)request.getAttribute("exception");

		if(exception == null) {
			setResponse(response, ErrorMessage.ACCESS_DENIED);
		}
		//잘못된 타입의 토큰인 경우
		else if(exception.equals(ErrorMessage.WRONG_TYPE_TOKEN.getMsg())) {
			setResponse(response, ErrorMessage.WRONG_TYPE_TOKEN);
		}
		else if(exception.equals(ErrorMessage.UNSUPPORTED_TOKEN.getMsg())) {
			setResponse(response, ErrorMessage.UNSUPPORTED_TOKEN);
		}
		//토큰 만료된 경우
		else if(exception.equals(ErrorMessage.EXPIRED_TOKEN.getMsg())) {
			setResponse(response, ErrorMessage.EXPIRED_TOKEN);
		}
		else if(exception.equals(ErrorMessage.ALREADY_LOGOUT.getMsg())) {
			setResponse(response, ErrorMessage.ALREADY_LOGOUT);
		}
		else {
			setResponse(response, ErrorMessage.TOKEN_NOT_EXIST);
		}

	}

	private void setResponse(HttpServletResponse response, ErrorMessage errorMessage) throws IOException {
		response.setContentType("application/json;charset=UTF-8");
		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

		JsonObject responseJson = new JsonObject();
		responseJson.addProperty("message", errorMessage.getMsg());
		responseJson.addProperty("code", errorMessage.getStatus().toString());

		response.getWriter().print(responseJson);
	}
}
