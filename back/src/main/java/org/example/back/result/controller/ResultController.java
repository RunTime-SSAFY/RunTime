package org.example.back.result.controller;

import org.example.back.result.dto.ResultReqDto;
import org.example.back.result.dto.ResultResDto;
import org.example.back.result.service.ResultService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/results")
public class
ResultController {

	private final ResultService resultService;

	@PostMapping
	public ResultResDto getResult(@RequestBody ResultReqDto record) {
		return resultService.getResult(record);
	}
}
