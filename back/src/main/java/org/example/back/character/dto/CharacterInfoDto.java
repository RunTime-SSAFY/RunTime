package org.example.back.character.dto;


import jakarta.persistence.Access;
import lombok.*;


public class CharacterInfoDto {

    @Getter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class infos {

        private Long id;
        private String name;
        private String imgUrl;
        private String detail;
        private Boolean owned;
        private Boolean check;

        @Builder
        infos(
                Long id,
                String name,
                String imgUrl,
                String detail,
                Boolean owned,
                Boolean check
        ) {
            this.id = id;
            this.name = name;
            this.imgUrl = imgUrl;
            this.detail=detail;
            this.owned = owned;
            this.check = check;
        }
    }
}

