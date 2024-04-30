package org.example.back.character.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CharacterRequestDto {

    private Long lastId;

    private int pageSize;

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
