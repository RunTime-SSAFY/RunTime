package org.example.back.character.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CharacterResponseDto {
    private List<CharacterInfoDto> characterList = new ArrayList<>();
    private Boolean hasNextPage;

    public CharacterResponseDto(Long id, String name, String imgUrl, Boolean owned, Boolean check) {

    }


//    public CharacterResponseDto(Long id, String name, String imgUrl, Boolean owned, Boolean check) {
//        this.id = id;
//        this.name = name;
//        this.imgUrl = imgUrl;
//        this.owned = owned;
//        this.check = check;
//    }
    @Data
    @NoArgsConstructor
    public class CharacterInfo {
        private Long id;
        private String name;
        private String imgUrl;
        private Boolean owned;
        private Boolean check;
    }


}




//    public (Long id, String name, String imgUrl, Boolean owned, Boolean check){
//        this.id=id;
//        this.name=name;
//        this.imgUrl=imgUrl;
//        this.owned=owned;
//        this.check=check;
//    }

//    @Builder
//    public hasNextPage(Boolean )
