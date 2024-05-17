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
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.NumberPath;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQuery;
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
		// 별칭을 사용한 prev_grade 필드를 위한 Path 정의
		NumberPath<Float> prevGoalPath = Expressions.numberPath(Float.class, "prev_goal");
		result.forEach(el->{
			list.add(AchievementResDto.builder()
				.currentAchievement(el.get(currentAchievement))
				.achievement(el.get(achievement))
				.character(el.get(character))
				.achievementType(el.get(achievementType))
				.prevGoal(el.get(prevGoalPath) == null ? 0.0f : el.get(prevGoalPath))
				.build());

		});

		return list;
	}



	private List<Tuple> findAchievementQuery(Long memberId) {
		return query.select(achievement, currentAchievement, achievementType, character,
				Expressions.as(
					JPAExpressions.select(achievement.goal.coalesce(0.0f))
					.from(achievement)
					.where(achievement.achievementType.id.eq(currentAchievement.achievementType.id)
						.and(achievement.grade.eq(currentAchievement.currentGrade.subtract(1))))
				, "prev_goal")
			)
			.from(achievement)
			.innerJoin(currentAchievement)
			.on(achievement.achievementType.id.eq(currentAchievement.achievementType.id)
				.and(currentAchievement.member.id.eq(memberId))
				.and(achievement.grade.eq(currentAchievement.currentGrade))
			).innerJoin(achievement.achievementType, achievementType)
			.innerJoin(achievement.character, character)
			.where(currentAchievement.achievementType.isHidden.and(currentAchievement.isReceived).not())
			.fetch();
	}
}
