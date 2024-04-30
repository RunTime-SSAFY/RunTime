package org.example.back.character.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@Builder

public class CharacterInfoDto {
    private Long id;
    private String name;
    private String imgUrl;
    private Boolean owned;
    private Boolean check;

    public CharacterInfoDto(Long id, String name, String imgUrl, Boolean owned, Boolean check) {
        this.id=id;
        this.name=name;
        this.imgUrl=imgUrl;
        this.owned=owned;
        this.check=check;
    }
}

