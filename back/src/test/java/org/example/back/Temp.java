package org.example.back;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@SpringBootTest  // 테스트 코드 작성을 위한 애노테이션
@Transactional  // 각각의 메서드 트랜잭션을 위한 애노테이션 -> 트랜잭션 걸고 종료 후 롤백: db 반영 안 됨
@RequiredArgsConstructor
public class Temp {

	private final TestService testService;

	@BeforeEach  // 초기화 작업
	public void before() {
		System.out.println("Test before");
	}

	@AfterEach  // 마무리 작업
	public void after() {
		System.out.println("Test after");
	}

	@Test  // 실제 테스트를 수행할 메서드를 지정하는 애노테이션
	@DisplayName("테스트를 위한 테스트 코드")  // 테스트 메서드 설명 추가
	public void test() throws Exception {
		/*
		* 테스트 메서드의 구성은 Given, When, Then으로 구성
		* Given: 주어진 시나리오 설정
		* When: 테스트할 기능을 호출하고 실행
		* Then: 기대 결과 검증 -> 결과 혹은 동작이 예상대로 수행되었는지 확인
		*/

		// Given
		System.out.println("Given");
		int number = 1;

		// When
		System.out.println("When");
		int generateNumber = testService.generate();

		// Then
		System.out.println("Then");
		assertThat(generateNumber).isEqualTo(number);
		// assertThat(actual).method(expect): 실제값(actual)과 기대값을 테스트 연산
	}
}

