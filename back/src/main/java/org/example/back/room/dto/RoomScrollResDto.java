package org.example.back.room.dto;

import lombok.Getter;
import java.util.List;

@Getter
public class RoomScrollResDto {
    private List<RoomResDto> data;
    private boolean hasNext;
    private Long lastId;

    public RoomScrollResDto(List<RoomResDto> data, boolean hasNext) {
        this.data = data;
        this.hasNext = hasNext;
        this.lastId = !data.isEmpty()?data.get(data.size()-1).getRoomId():0;
    }
}
