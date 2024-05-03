package org.example.back.record.dto;


import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class RecordListResponseDto {

    private List<RecordDto> recordList;
    private boolean hasNext;
    private Long lastId;

    public RecordListResponseDto(List<RecordDto> recordList, boolean hasNext) {
        this.recordList = recordList;
        this.hasNext = hasNext;
        this.lastId = !recordList.isEmpty() ? recordList.get(recordList.size()-1).getId() : 0;
    }
}
