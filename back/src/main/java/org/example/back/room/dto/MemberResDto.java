package org.example.back.room.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberResDto {
    private Long memberId;
    private String nickname;
    private String characterImgUrl;
    private boolean isManager; // 방장이면 true, 그렇지 않으면 false
    private boolean isReady; // 게임을 시작할 준비가 되었으면 true, 그렇지 않으면 false

    public void setManager() {
        this.isManager = true;
    }

}
