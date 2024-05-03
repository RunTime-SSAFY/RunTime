package org.example.back.db.enums;

import lombok.Getter;

@Getter
public enum GameMode {
    BATTLE("배틀모드"),
    CUSTOM("커스텀모드"),
    PRACTICE("연습모드");

    private final String name;
    GameMode(String name) { this.name = name; }
}
