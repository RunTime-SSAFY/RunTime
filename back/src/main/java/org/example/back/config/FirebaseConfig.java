package org.example.back.config;

import java.io.FileInputStream;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class FirebaseConfig {

	private FirebaseApp firebaseApp;

	@PostConstruct
	public void init(){
		try {
				ClassPathResource resource = new ClassPathResource("serviceAccountKey.json");
				FirebaseOptions options = new FirebaseOptions.Builder()
					.setCredentials(GoogleCredentials.fromStream(resource.getInputStream()))
					.build();
				if(FirebaseApp.getApps().isEmpty()) {
					FirebaseApp.initializeApp(options);
				}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
