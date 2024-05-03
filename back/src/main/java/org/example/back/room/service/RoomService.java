package org.example.back.room.service;

import lombok.RequiredArgsConstructor;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.Room;
import org.example.back.db.entity.RoomMember;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RoomMemberRepository;
import org.example.back.db.repository.RoomRepository;
import org.example.back.db.enums.Status;
import org.example.back.exception.MemberNotFoundException;
import org.example.back.exception.RoomNotFoundException;
import org.example.back.room.dto.*;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Slice;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class RoomService {
    private final MemberRepository memberRepository;
    private final RoomRepository roomRepository;
    private final RoomMemberRepository roomMemberRepository;

    @Transactional
    public PostRoomResDto postRoom(PostRoomReqDto postRoomReqDto) {
        // 나 가져오기
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        Member me =  memberRepository.findById(myMemberId).orElseThrow(MemberNotFoundException::new);

        // 방을 만드는 데 필요한 정보 가져오기
        int capacity = postRoomReqDto.getCapacity();
        double distance = postRoomReqDto.getDistance();
        String password = postRoomReqDto.getPassword();
        String name = postRoomReqDto.getName();

        // room 만들기
        Room room = Room.builder()
                .manager(me)
                .name(name)
                .status(Status.WAITING)
                .password(password)
                .capacity(capacity)
                .build();

        Room savedRoom = roomRepository.save(room);

        // roomMember 만들기
        RoomMember roomMember = RoomMember.builder()
                .room(savedRoom)
                .member(me)
                .isReady(false)
                .build();

        roomMemberRepository.save(roomMember);

        // postRoomResDto 돌려주기
        return savedRoom.toPostRoomResDto();

    }

    @Transactional(readOnly = true)
    public RoomScrollResDto getRooms(Long lastId, int pageSize, String searchWord, boolean isSecret) { // 모든 방 가져오기
        if (searchWord == null) searchWord = "";

        Slice<RoomResDto> roomResDtos = roomRepository.findAll(lastId, pageSize, searchWord, isSecret);

        return new RoomScrollResDto(roomResDtos.getContent(), roomResDtos.hasNext());
    }

    @Transactional
    public PatchRoomResDto patchRoomName(PatchRoomNameReqDto patchRoomReqDto) {
        Long roomId = patchRoomReqDto.getRoomId();
        String name = patchRoomReqDto.getName();

        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));

        room.patchRoomName(name);

        return PatchRoomResDto.builder()
                .roomId(roomId)
                .build();
    }



}
