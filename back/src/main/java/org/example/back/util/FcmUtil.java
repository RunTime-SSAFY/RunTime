package org.example.back.util;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.example.back.db.entity.Member;
import org.example.back.db.enums.AlertType;
import org.springframework.stereotype.Component;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@RequiredArgsConstructor
@Slf4j
public class FcmUtil {

	public void sendAlert(AlertType alertType, String title, String body, Member receiver, Long targetId)
		 {
		try{
			String fcmToken = receiver.getFcmToken();
			String receiverName = receiver.getNickname();
			String currentTime = LocalDateTime.now().toString();

			Message message = Message.builder()
				.putData("targetId", targetId.toString())
				.putData("time", currentTime)
				.putData("type", alertType.toString())
				.setToken(fcmToken)
				.build();
			System.out.println("?????머고");
			String response = FirebaseMessaging.getInstance().send(message);
			log.info("FCM send: {}",response);
		}catch (FirebaseMessagingException e){
			log.debug("전송 실패~");
		}




		// switch (alertType) {
		// 	case FRIEND -> {
		// 		title = "친구";
		//
		// 	}
		// 	case INVITE ->
		// }
	}

}
