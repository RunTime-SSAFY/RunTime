package org.example.back.db.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.example.back.db.entity.QRoom;
import org.example.back.db.entity.Room;
import org.example.back.room.dto.RoomResDto;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class RoomCustomImpl implements RoomCustom {

    private final JPAQueryFactory query;
    private final QRoom room = QRoom.room;

    @Override
    public Slice<RoomResDto> findAll(Long lastId, int pageSize, String searchWord, boolean isSecret) {
        Pageable pageable = PageRequest.of(1, pageSize);
        List<Room> rooms = query.selectFrom(room)
                .where(isSecretRoom(isSecret))
                .where(room.name.contains(searchWord))
                .where(ltRoomId(lastId))
                .orderBy(room.id.desc())
                .limit(pageSize + 1)
                .fetch();

        List<RoomResDto> roomResDtos = rooms.stream().map(Room::toRoomResDto).toList();

        return checkLastPage(pageable, roomResDtos);
    }

    private BooleanExpression isSecretRoom(boolean isSecret) { // 비밀방을 검색하는 경우와 전체 방을 검색하는 경우
        if (isSecret) {
            return room.password.isNotNull();
        }

        return null;
    }

    private BooleanExpression ltRoomId(Long roomId) {
        if (roomId == null) return null;

        return room.id.lt(roomId);
    }

    private Slice<RoomResDto> checkLastPage(Pageable pageable, List<RoomResDto> results) {
        boolean hasNext = false;

        if (results.size() > pageable.getPageSize()) {
            hasNext = true;
            results.remove(pageable.getPageSize());
        }

        return new SliceImpl<>(results, pageable, hasNext);

    }

}
