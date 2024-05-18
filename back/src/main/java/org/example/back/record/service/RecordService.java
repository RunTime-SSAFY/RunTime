package org.example.back.record.service;

import lombok.RequiredArgsConstructor;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.Record;
import org.example.back.db.enums.GameMode;
import org.example.back.db.enums.StatisticType;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.exception.RecordNotFoundException;
import org.example.back.exception.StatisticBadRequestException;
import org.example.back.record.dto.*;
import org.example.back.util.EnumUtils;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RecordService {
    private final MemberRepository memberRepository;
    private final RecordRepository recordRepository;

    @Transactional(readOnly = true)
    public RecordListResponseDto getAllRecords(Long lastId, Integer pageSize, String gameModeStr) {
        Member member = getMember();

        // String으로 들어온 열거값을 대소문자 구분하지 않고 찾아준다.
        GameMode gameMode = null;
        System.out.println("gameModeStr: " + gameModeStr);
        if(gameModeStr != null && !gameModeStr.isEmpty()) gameMode = EnumUtils.getIgnoreCaseOrThrow(GameMode.class, gameModeStr);

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

        return RecordResponseDto.builder()
                .courseImgUrl(record.getCourseImgUrl())
                .id(record.getId())
                .runStartTime(record.getRunStartTime())
                .runEndTime(record.getRunEndTime())
                .gameMode(record.getGameMode())
                .ranking(record.getRanking())
                .distance(record.getDistance())
                .averagePace(record.getPace())
                .duration(record.getDuration())
                .calorie(record.getCalorie())
                .build();
    }

    @Transactional(readOnly = true)
    public StatisticResponseDto getStatistic(String typeStr, LocalDate selectedDate) {
        Member member = getMember();

        // enum type 조회
        StatisticType type = EnumUtils.getIgnoreCaseOrThrow(StatisticType.class, typeStr);

        // 타입에 따라 로직 처리 및 responseDto 반환
        StatisticDto statisticDto;
        return switch (type) {
            case MONTH -> {
                if (selectedDate == null) throw new StatisticBadRequestException();
                statisticDto = recordRepository.getStatisticByMonth(member, selectedDate);
                statisticDto.setMonth(selectedDate.getMonthValue());
                statisticDto.setYear(selectedDate.getYear());
                yield buildStatisticResponseDto(statisticDto, type);
            }
            case YEAR -> {
                if (selectedDate == null) throw new StatisticBadRequestException();
                statisticDto = recordRepository.getStatisticByYear(member, selectedDate);
                yield buildStatisticResponseDto(statisticDto, type);
            }
            case ALL -> {
                statisticDto = recordRepository.getStatisticByAll(member);
                yield buildStatisticResponseDto(statisticDto, type);
            }
        };

    }

    // 통계 responseDto 만드는 빌더 함수
    private StatisticResponseDto buildStatisticResponseDto(StatisticDto from, StatisticType type) {
        Long memberId = SecurityUtil.getCurrentMemberId();
        List<Integer> runDateList = null;
        if(type == StatisticType.MONTH){
            runDateList = recordRepository.findRunDate(memberId,from.getYear(), from.getMonth());
        }


        // query의 sum() 로직에서 null이 반환될 수 있음
        return StatisticResponseDto.builder()
                .type(type)
                .runDateList(runDateList)
                .countDay(from.getCountDay() == null ? 0 : from.getCountDay())
                .calorie(from.getCalorie() == null ? 0 : from.getCalorie())
                .distance(from.getDistance() == null ? 0.0f : from.getDistance())
                .duration(from.getDuration() == null ? 0L : from.getDuration())
                .build();
    }

    private Member getMember() {
        return memberRepository.findById(SecurityUtil.getCurrentMemberId())
                .orElseThrow(MemberNotFoundException::new);
    }

}
