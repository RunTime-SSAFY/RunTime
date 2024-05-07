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

    @PatchMapping("/{roomId}/name")
    public ResponseEntity<PatchRoomResDto> patchRoomName(@PathVariable Long roomId, @RequestBody PatchRoomNameReqDto patchRoomNameReqDto) {
        PatchRoomResDto patchRoomResDto = roomService.patchRoomName(roomId, patchRoomNameReqDto);

        return ResponseEntity.ok().body(patchRoomResDto);
    }

    @PatchMapping("/{roomId}/distance")
    public ResponseEntity<PatchRoomResDto> patchRoomDistance(@PathVariable Long roomId, @RequestBody PatchRoomDistanceReqDto patchRoomDistanceReqDto) {
        PatchRoomResDto patchRoomResDto = roomService.patchRoomDistance(roomId, patchRoomDistanceReqDto);

        return ResponseEntity.ok().body(patchRoomResDto);
    }

    @PatchMapping("/{roomId}/password")
    public ResponseEntity<PatchRoomResDto> patchRoomPassword(@PathVariable Long roomId, @RequestBody PatchRoomPasswordReqDto patchRoomPasswordReqDto) {
        PatchRoomResDto patchRoomResDto = roomService.patchRoomPassword(roomId, patchRoomPasswordReqDto);

        return ResponseEntity.ok().body(patchRoomResDto);
    }

    @PatchMapping("/{roomId}/capacity")
    public ResponseEntity<PatchRoomResDto> patchRoomCapacity(@PathVariable Long roomId, @RequestBody PatchRoomCapacityReqDto patchRoomCapacityReqDto) {
        PatchRoomResDto patchRoomResDto = roomService.patchRoomCapacity(roomId, patchRoomCapacityReqDto);

        return ResponseEntity.ok().body(patchRoomResDto);
    }

    @PostMapping("/{roomId}/enter")
    public ResponseEntity<RoomMemberResDto> enterRoom(@PathVariable Long roomId, @RequestBody EnterRoomReqDto enterRoomReqDto) {
        String password = enterRoomReqDto.getPassword();
        RoomMemberResDto roomMemberResDto = roomService.enterRoom(roomId, password);

        return ResponseEntity.status(HttpStatus.CREATED).body(roomMemberResDto);
    }

    @PatchMapping("/{roomId}/ready")
    public ResponseEntity<RoomMemberResDto> readyRoom(@PathVariable Long roomId) {
        RoomMemberResDto roomMemberResDto = roomService.readyRoom(roomId);

        return ResponseEntity.ok().body(roomMemberResDto);
    }

    @DeleteMapping("/{roomId}/exit")
    public ResponseEntity<RoomMemberResDto> exitRoom(@PathVariable Long roomId) {
        RoomMemberResDto roomMemberResDto = roomService.exitRoom(roomId);

        return ResponseEntity.ok().body(roomMemberResDto);
    }

    @PatchMapping("/{roomId}/start")
    public ResponseEntity<Void> startGame(@PathVariable Long roomId) {
        roomService.startGame(roomId);

        return ResponseEntity.ok().build();

    }



}
