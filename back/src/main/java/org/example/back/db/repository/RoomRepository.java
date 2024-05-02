package org.example.back.db.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.example.back.db.entity.Room;
public interface RoomRepository extends JpaRepository<Room, Long>, RoomCustom {

}
