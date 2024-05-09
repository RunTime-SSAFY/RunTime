package org.example.back.matching.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ReadyReqDto {
    private boolean ready; // 매칭된 상대와의 게임에 동의하면 true, 동의 취소하면 false
}
