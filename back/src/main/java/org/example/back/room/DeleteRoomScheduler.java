package org.example.back.room;

import lombok.RequiredArgsConstructor;
import org.example.back.db.entity.Room;
import org.example.back.db.repository.RoomRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class DeleteRoomScheduler {
    private final RoomRepository roomRepository;
    @Scheduled(fixedDelay = 1000 * 10)
    public void deleteRoom() {
        List<Room> rooms = roomRepository.findAll();

        for (Room r: rooms) {
            if (r.getRoomMembers() == null || r.getRoomMembers().isEmpty()) {
                roomRepository.deleteById(r.getId());
            }
        }
    }
}
