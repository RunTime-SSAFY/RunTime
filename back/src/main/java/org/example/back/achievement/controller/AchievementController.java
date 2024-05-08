package org.example.back.achievement.controller;

import java.util.List;

import org.example.back.achievement.dto.AchievementResDto;
import org.example.back.achievement.dto.CheckAchievementResDto;
import org.example.back.achievement.service.AchievementService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/achievements")
@RequiredArgsConstructor
public class AchievementController {

	private final AchievementService achievementService;

	@GetMapping
	public ResponseEntity<List<AchievementResDto>> getOwnAchievements() {
		List<AchievementResDto> achievementList = achievementService.findOwn();
		return ResponseEntity.ok(achievementList);
	}

	@PatchMapping
	public ResponseEntity<CheckAchievementResDto> updateAchievement(){
		return ResponseEntity.ok(achievementService.updateAchievement());
	}

	@PatchMapping("/{achievementTypeId}")
	public ResponseEntity<AchievementResDto> receiveReward(@PathVariable Long achievementTypeId) {

		AchievementResDto achievementResDto = achievementService.receiveReward(achievementTypeId);

		return ResponseEntity.ok(achievementResDto);
	}
}
