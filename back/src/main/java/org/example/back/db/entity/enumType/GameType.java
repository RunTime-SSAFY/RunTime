package org.example.back.db.entity.enumType;

public enum GameType implements EnumMapperType {

    BATTLE("배틀모드"),
    CUSTOM("커스텀모드"),
    PRACTICE("연습모드");

    private String title;

    GameType(String title) { this.title = title; }

    @Override
    public String getCode() {
        return name();
    }

    @Override
    public String getTitle() {
        return title;
    }

    // 참고 블로그 : https://techblog.woowahan.com/2527/
}
