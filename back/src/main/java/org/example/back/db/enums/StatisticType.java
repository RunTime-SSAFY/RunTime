package org.example.back.db.enums;

import lombok.Getter;

@Getter
public enum StatisticType {
    YEAR("연통계"),
    MONTH("월통계"),
    ALL("전체통계");

    private final String name;
    StatisticType(String name) { this.name = name; }
}
