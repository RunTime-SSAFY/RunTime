package org.example.back.record.service;

import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.EnumUtils;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.Record;
import org.example.back.db.enums.GameMode;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.EnumBadRequestException;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.exception.RecordNotFoundException;
import org.example.back.record.dto.RecordDto;
import org.example.back.record.dto.RecordListResponseDto;
import org.example.back.record.dto.RecordResponseDto;
import org.example.back.record.dto.StatisticsResponseDto;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RecordService {
    private final MemberRepository memberRepository;
    private final RecordRepository recordRepository;

    @Transactional(readOnly = true)
    public RecordListResponseDto getAllRecords(Long lastId, Integer pageSize, String gameModeStr) {
        Member member = getMember();

        // String으로 들어온 열거값을 대소문자 구분하지 않고 찾아준다.
        GameMode gameMode = EnumUtils.getEnumIgnoreCase(GameMode.class, gameModeStr);

        // 잘못된 gameMode가 입력되면 exception 처리한다.
        gameMode = Optional.ofNullable(gameMode)
                .orElseThrow(EnumBadRequestException::new);

        // Slice로 데이터들을 받아온다.
        Slice<RecordDto> recordSlice = recordRepository.findAll(lastId, pageSize, member, gameMode);

        // Slice에서 콘텐츠와 다음 페이지 여부를 분리한다.
        List<RecordDto> recordDtoList = recordSlice.getContent();
        boolean hasNextPage = recordSlice.hasNext();

        return new RecordListResponseDto(recordDtoList, hasNextPage);
    }

    @Transactional(readOnly = true)
    public RecordResponseDto getRecord(Long recordId) {
        Record record = recordRepository.findById(recordId)
                .orElseThrow(RecordNotFoundException::new);

        // coordinates 데이터는 어떻게 받아올 것인가?

        return RecordResponseDto.builder()
                .coordinates(null)
                .recordId(record.getId())
                .runStartTime(record.getRunStartTime())
                .runEndTime(record.getRunEndTime())
                .gameMode(record.getGameMode())
                .ranking(record.getRanking())
                .distance(record.getDistance())
                .averagePace(record.getPace())
                .calorie(record.getCalorie())
                .build();
    }

    @Transactional(readOnly = true)
    public StatisticsResponseDto getStatistics(Integer year, Integer month) {
        Member member = getMember();
        // 테이블을 만들 것인가, 아니면 조회할떄마다 계산할 것인가.

        return null;
    }










    private Member getMember() {
        return memberRepository.findById(SecurityUtil.getCurrentMemberId())
                .orElseThrow(MemberNotFoundException::new);
    }

}
