package org.example.back.character.dto;


import lombok.*;

public class CharacterRequestDto {

    @Getter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class list{
        private Long lastId;
        private int pageSize;

        @Builder
        list(
                Long lastId,
                int pageSize
        ){
            this.lastId=lastId;
            this.pageSize=pageSize;
        }
    }

}

//public class CharacterRequestDto {
//    @Getter
//    @NoArgsConstructor(access = AccessLevel.PROTECTED)
//    public static class characterList{
//        //@NotNull(message = "[CharacterRequestDto.characterList]lastId 는 Null일 수 없습니다.")
//        private Long lastId;
//        //@NotNull(message = "[CharacterRequestDto.characterList]pageSize 는 Null일 수 없습니다.")
//        private int pageSize;
//
//    }
//
//}
