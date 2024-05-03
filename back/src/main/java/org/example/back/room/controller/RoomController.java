package org.example.back.room.controller;

import lombok.RequiredArgsConstructor;
import org.example.back.room.dto.*;
import org.example.back.room.service.RoomService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/rooms")
public class RoomController {

    private final RoomService roomService;
    @PostMapping("")
    public ResponseEntity<PostRoomResDto> postRoom(@RequestBody PostRoomReqDto postRoomReqDto) {
        PostRoomResDto postRoomResDto = roomService.postRoom(postRoomReqDto);

        return ResponseEntity.status(HttpStatus.CREATED).body(postRoomResDto);

    }

    @GetMapping("")
    public ResponseEntity<RoomScrollResDto> getRooms(@RequestParam(value = "lastId", required = false) Long lastId, @RequestParam("pageSize") int pageSize, @RequestParam(value="searchWord", required = false) String searchWord, @RequestParam("isSecret") boolean isSecret) {

        RoomScrollResDto roomScrollResDto = roomService.getRooms(lastId, pageSize, searchWord, isSecret);

        return ResponseEntity.ok().body(roomScrollResDto);
    }

    @PatchMapping("/name")
    public ResponseEntity<PatchRoomResDto> patchRoomName(@RequestBody PatchRoomNameReqDto patchRoomNameReqDto) {
        PatchRoomResDto patchRoomResDto = roomService.patchRoomName(patchRoomNameReqDto);

        return ResponseEntity.ok().body(patchRoomResDto);
    }

    @PatchMapping("/distance")
    public ResponseEntity<PatchRoomResDto> patchRoomDistance(@RequestBody PatchRoomDistanceReqDto patchRoomDistanceReqDto) {
        PatchRoomResDto patchRoomResDto = roomService.patchRoomDistance(patchRoomDistanceReqDto);

        return ResponseEntity.ok().body(patchRoomResDto);
    }

    @PatchMapping("/password")
    public ResponseEntity<PatchRoomResDto> patchRoomPassword(@RequestBody PatchRoomPasswordReqDto patchRoomPasswordReqDto) {
        PatchRoomResDto patchRoomResDto = roomService.patchRoomPassword(patchRoomPasswordReqDto);

        return ResponseEntity.ok().body(patchRoomResDto);
    }

    @PatchMapping("/capacity")
    public ResponseEntity<PatchRoomResDto> patchRoomCapacity(@RequestBody PatchRoomCapacityReqDto patchRoomCapacityReqDto) {
        PatchRoomResDto patchRoomResDto = roomService.patchRoomCapacity(patchRoomCapacityReqDto);

        return ResponseEntity.ok().body(patchRoomResDto);
    }

    @PostMapping("/{roomId}/enter")
    public ResponseEntity<RoomMemberResDto> enterRoom(@PathVariable Long roomId) {
        RoomMemberResDto roomMemberResDto = roomService.enterRoom(roomId);

        return ResponseEntity.status(HttpStatus.CREATED).body(roomMemberResDto);
    }

    @PatchMapping("/{roomId}/ready")
    public ResponseEntity<RoomMemberResDto> readyRoom(@PathVariable Long roomId) {
        RoomMemberResDto roomMemberResDto = roomService.readyRoom(roomId);

        return ResponseEntity.ok().body(roomMemberResDto);
    }



}
