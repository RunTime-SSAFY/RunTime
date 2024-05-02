package org.example.back.unlocked_character.dto;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

public class UnlockedCharacterDto {
    @Getter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class unlocked{
        private Long characterId;
        private Long memberId;
        private Boolean isCheck;

        @Builder
        unlocked(
                Long characterId,
                Long memberId,
                Boolean isCheck
        ){
            this.characterId=characterId;
            this.memberId=memberId;
            this.isCheck=isCheck;
        }
    }
}
