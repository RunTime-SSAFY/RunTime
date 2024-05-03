package org.example.back.common.mattermost;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.example.back.common.mattermost.MatterMostMessageDto.Attachment;
import org.example.back.common.mattermost.MatterMostMessageDto.Attachments;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
@RequiredArgsConstructor
public class MatterMostSender {
	private Logger log = LoggerFactory.getLogger(MatterMostSender.class);

	@Value("${notification.mattermost.enabled}")
	private boolean mmEnabled;
	@Value("${notification.mattermost.webhook-url}")
	private String webhookUrl;

	private final RestTemplate restTemplate;
	private final MattermostProperties mmProperties;
	private final ObjectMapper objectMapper;


	public void sendMessage(Exception exception, String uri, String params) {
		if (!mmEnabled)
			return;

		try {
			Attachment attachment = Attachment.builder()
					.channel(mmProperties.getChannel())
					.authorIcon(mmProperties.getAuthorIcon())
					.authorName(mmProperties.getAuthorName())
					.color(mmProperties.getColor())
					.pretext(mmProperties.getPretext())
					.title(mmProperties.getTitle())
					.text(mmProperties.getText())
					.footer(mmProperties.getFooter())
					.build();

			attachment.addExceptionInfo(exception, uri, params);
			Attachments attachments = new Attachments(attachment);
			attachments.addProps(exception);
			String payload = objectMapper.writeValueAsString(attachments);

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);

			HttpEntity<String> entity = new HttpEntity<>(payload, headers);
			restTemplate.postForEntity(webhookUrl, entity, String.class);

		} catch (JsonProcessingException e) {
			log.error("Error while converting object to JSON: {}", e.getMessage());
		} catch (Exception e) {
			log.error("Error sending Mattermost message: {}", e.getMessage());
		}
	}
}
