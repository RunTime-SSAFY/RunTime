package org.example.back.character.dto;



import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;


public class CharacterResponseDto {
    @Getter
    @NoArgsConstructor
    public static class list {
        private List<CharacterInfoDto> list = new ArrayList<>();
        private Boolean hasNextPage;

        @Builder
        list(
                List<CharacterInfoDto> characterList,
                Boolean hasNextPage
        ){
            this.list=list;
            this.hasNextPage=hasNextPage;
        }
//    public CharacterResponseDto(Long id, String name, String imgUrl, Boolean owned, Boolean check) {
//
//    }
    }


}


