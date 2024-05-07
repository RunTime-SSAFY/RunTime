package org.example.back.db.repository;

import org.example.back.db.entity.Character;
import org.example.back.db.entity.QAchievement;
import org.example.back.db.entity.QCharacter;
import org.springframework.stereotype.Repository;

import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CharacterCustomImpl implements CharacterCustom{

	private final JPAQueryFactory query;

	private final QCharacter character = QCharacter.character;
	private final QAchievement achievement = QAchievement.achievement;

	@Override
	public Character findByAchievementTypeAndGrade(Long achievementTypeId, int grade){
		return query.selectFrom(character)
			.where(character.achievement.id.eq(JPAExpressions.select(achievement.id)
				.from(achievement)
				.where(achievement.grade.eq(grade),
					achievement.achievementType.id.eq(achievementTypeId)
				)))
			.fetchFirst();
	}
}
