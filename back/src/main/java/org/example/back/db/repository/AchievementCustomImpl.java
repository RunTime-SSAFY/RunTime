package org.example.back.db.repository;

import java.util.ArrayList;
import java.util.List;

import org.example.back.achievement.dto.AchievementResDto;
import org.example.back.db.entity.QAchievement;
import org.example.back.db.entity.QAchievementType;
import org.example.back.db.entity.QCharacter;
import org.example.back.db.entity.QCurrentAchievement;
import org.springframework.stereotype.Repository;

import com.querydsl.core.Tuple;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AchievementCustomImpl implements AchievementCustom{

	private final JPAQueryFactory query;
	private final QAchievement achievement= QAchievement.achievement;
	private final QCurrentAchievement currentAchievement = QCurrentAchievement.currentAchievement;
	private final QAchievementType achievementType = QAchievementType.achievementType;
	private final QCharacter character = QCharacter.character;
	@Override
	public List<AchievementResDto> findOwnAchievement(Long memberId) {

		List<Tuple> result = findAchievementQuery(memberId);

		List<AchievementResDto> list = new ArrayList<>();
		result.forEach(el->{
			System.out.println(el.get(character).getId());
			list.add(AchievementResDto.builder()
					.currentAchievement(el.get(currentAchievement))
					.achievement(el.get(achievement))
					.character(el.get(character))
					.achievementType(el.get(achievementType))
				.build());
		});

		return list;
	}



	private List<Tuple> findAchievementQuery(Long memberId) {
		return query.select(achievement, currentAchievement, achievementType, character)
			.from(achievement)
			.join(currentAchievement).on(achievement.achievementType.id.eq(currentAchievement.achievementType.id))
			.join(achievementType).on(achievement.achievementType.id.eq(achievementType.id))
			.join(character).on(character.achievement.id.eq(achievement.id))
			.where(achievement.grade.eq(currentAchievement.currentGrade),
				currentAchievement.member.id.eq(memberId))
			.fetch();
	}
}
