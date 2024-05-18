package org.example.back.achievement.dto;

import java.util.Objects;

import org.example.back.db.entity.Achievement;
import org.example.back.db.entity.AchievementType;
import org.example.back.db.entity.Character;
import org.example.back.db.entity.CurrentAchievement;
import org.example.back.db.enums.AchievementCriteriaType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AchievementResDto {
	private Long id;
	private Long type;
	private String name;
	private String detail;
	private AchievementCriteriaType criteria;
	private Integer grade;
	private Float goal;
	private Float prevGoal;
	private Float progress;
	private String characterName;
	private String characterImgUrl;
	private Boolean isFinal;
	private Boolean isComplete;
	private Boolean isReceive;
	private Boolean isHidden;


	@Builder
	public AchievementResDto(Achievement achievement, CurrentAchievement currentAchievement,
		AchievementType achievementType, Character character, float prevGoal) {

		this.id = achievement.getId();
		this.type = achievementType.getId();
		this.name = achievement.getName();
		this.detail = achievement.getDetail();
		this.criteria = achievementType.getCriteria();
		this.grade = achievement.getGrade();
		this.goal = achievement.getGoal();
		this.progress = currentAchievement.getProgress();
		this.characterImgUrl = character.getImgUrl();
		this.characterName = character.getName();
		this.isFinal = Objects.equals(achievement.getGrade(), achievementType.getFinalGrade());
		this.isComplete = currentAchievement.getProgress()>=achievement.getGoal();
		this.isReceive = currentAchievement.getIsReceived();
		this.prevGoal = prevGoal;
		this.isHidden = achievementType.getIsHidden();
	}



}
