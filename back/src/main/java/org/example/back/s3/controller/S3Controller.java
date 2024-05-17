package org.example.back.s3.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.example.back.s3.service.S3Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/s3")
public class S3Controller {

	private static final Logger logger = LoggerFactory.getLogger(S3Controller.class);
	private final S3Service s3Service;

	@PostMapping("/upload")
	public ResponseEntity<String> uploadFile(@RequestParam("result") MultipartFile file) {
		try {
			Path tempFile = Files.createTempFile("temp", file.getOriginalFilename());
			file.transferTo(tempFile.toFile());
			String fileUrl = s3Service.uploadFile("user_track_img", tempFile);
			return ResponseEntity.ok(fileUrl);
		} catch (IOException e) {
			logger.error("Failed to upload file", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to upload file");
		}
	}
}
