package org.example.back.s3.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.example.back.s3.service.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
@RequestMapping("/api/s3")
public class S3Controller {

	private final S3Service s3Service;

	@PostMapping("/upload")
	public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file) {
		String key = file.getOriginalFilename();

		try {
			Path tempFile = Files.createTempFile("temp", file.getOriginalFilename());
			file.transferTo(tempFile.toFile());
			String eTag = s3Service.uploadFile(key, tempFile);
			return ResponseEntity.ok("File uploaded successfully with eTag: " + eTag);
		} catch (IOException e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to upload file");
		}
	}
}
