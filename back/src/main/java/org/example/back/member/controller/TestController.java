package org.example.back.member.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/tests")
public class TestController {

	@PostMapping
	public ResponseEntity<String> test(){
		return ResponseEntity.ok("test ok ");
	}
}
