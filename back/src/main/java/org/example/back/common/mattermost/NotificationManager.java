package org.example.back.common.mattermost;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class NotificationManager {
	private Logger log = LoggerFactory.getLogger(NotificationManager.class);
	
	@Autowired
	private MatterMostSender mmSender;

	public void sendNotification(Exception e, String uri, String params) {
		log.info("#### SEND Notification");
		mmSender.sendMessage(e, uri, params);
	}

}
