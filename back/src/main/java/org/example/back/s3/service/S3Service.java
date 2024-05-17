package org.example.back.s3.service;

import static org.example.back.util.SecurityUtil.*;

import java.nio.file.Path;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Response;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectResponse;

@Service
@RequiredArgsConstructor
public class S3Service {

	private static final Logger logger = LoggerFactory.getLogger(S3Service.class);

	private final S3Client s3Client;
	@Value("${s3.bucket.name}")
	private String bucketName;
	@Value("${cloudfront.url}")
	private String cloudFrontUrl;

	public String uploadFile(String folder, Path filePath) {
		Long memberId = getCurrentMemberId();
		String memberFolder = folder + "/" + memberId;

		int fileCount = getFileCount(memberFolder);
		String fileName = String.valueOf(fileCount + 1);  // 멤버 폴더의 파일 수에 따라 이름 지정
		String fullPath = memberFolder + "/" + fileName;

		try {
			PutObjectRequest putObjectRequest = PutObjectRequest.builder()
				.bucket(bucketName)
				.key(fullPath)
				.build();

			PutObjectResponse response = s3Client.putObject(putObjectRequest, filePath);
			logger.info("File uploaded to S3 with eTag: {}", response.eTag());
			return cloudFrontUrl + "/" + fullPath;
		} catch (Exception e) {
			logger.error("Failed to upload file", e);
			throw new RuntimeException("Failed to upload file to S3", e);
		}
	}

	private int getFileCount(String folder) {
		ListObjectsV2Request listObjectsV2Request = ListObjectsV2Request.builder()
			.bucket(bucketName)
			.prefix(folder + "/")
			.build();

		ListObjectsV2Response listObjectsV2Response = s3Client.listObjectsV2(listObjectsV2Request);
		return listObjectsV2Response.contents().size();
	}
}
