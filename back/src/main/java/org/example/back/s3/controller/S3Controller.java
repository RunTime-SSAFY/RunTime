package org.example.back.s3.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.example.back.util.S3Util;
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

	private final S3Util s3Util;
	private static final Logger logger = LoggerFactory.getLogger(S3Controller.class);

	@PostMapping("/upload")
	public ResponseEntity<String> uploadFile(@RequestParam("app") MultipartFile file) {
		try {
			String tempDir = System.getProperty("java.io.tmpdir");
			Path tempFile = Paths.get(tempDir, file.getOriginalFilename());  // 원본 파일명

			file.transferTo(tempFile.toFile());
			String fileUrl = s3Util.uploadFileOrImage("app", tempFile, null);
			return ResponseEntity.ok(fileUrl);
		} catch (IOException e) {
			logger.error("Failed to upload file", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to upload file");
		}
	}
}
