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



}
