package org.example.back.s3.service;

import java.nio.file.Path;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectResponse;

@Service
@RequiredArgsConstructor
public class S3Service {

	private final S3Client s3Client;
	@Value("${s3.bucket.name}")
	private String bucketName;

	public String uploadFile(String key, Path filePath) {
		try {
			PutObjectRequest putObjectRequest = PutObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();

			PutObjectResponse response = s3Client.putObject(putObjectRequest, filePath);
			return response.eTag();
		} catch (Exception e) {
			throw new RuntimeException("Failed to upload file to S3", e);
		}
	}
}
