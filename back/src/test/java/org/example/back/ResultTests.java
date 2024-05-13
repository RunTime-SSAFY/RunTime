package org.example.back;

import static org.junit.jupiter.api.Assertions.*;

import org.example.back.db.enums.GameMode;
import org.example.back.result.dto.ResultReqDto;
import org.example.back.result.dto.ResultResDto;
import org.example.back.result.service.ResultService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
@Transactional
public class ResultTests {
	@Autowired
	private ResultService resultService;

	@Test
	public void testGetResult_SuccessfulResult() {
		ResultReqDto record = new ResultReqDto();
		record.setMemberId(1L);
		record.setGameMode(GameMode.BATTLE);
		record.setRanking(1);
		record.setDistance(1.0F);
		record.setDuration(100);
		record.setAvgSpeed(1.0F);
		record.setPace(10);
		record.setCalorie(1);

		ResultResDto result = resultService.getResult(record);

		assertNotNull(result);
		assertEquals(1000, result.getBeforeScore());
	}
}
