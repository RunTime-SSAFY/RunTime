package org.example.back.db.enums;

import lombok.Getter;

@Getter
public enum StatisticsType {
    YEAR("연통계"),
    MONTH("월통계"),
    ALL("전체통계");

    private final String name;
    StatisticsType(String name) { this.name = name; }
}
