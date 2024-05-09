package org.example.back.room.service;

import lombok.RequiredArgsConstructor;
import org.example.back.common.CustomException;
import org.example.back.db.entity.Member;
import org.example.back.db.entity.Room;
import org.example.back.db.entity.RoomMember;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RoomMemberRepository;
import org.example.back.db.repository.RoomRepository;
import org.example.back.db.enums.Status;
import org.example.back.exception.*;
import org.example.back.room.dto.*;
import org.example.back.util.SecurityUtil;
import org.springframework.data.domain.Slice;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@RequiredArgsConstructor
public class RoomService {
    private final MemberRepository memberRepository;
    private final RoomRepository roomRepository;
    private final RoomMemberRepository roomMemberRepository;
    private final SimpMessagingTemplate messagingTemplate;
    private final PasswordEncoder passwordEncoder;
    private final RedisTemplate<String, String> redisTemplate;

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

        // 방 비밀번호 hashing
        String hashedPassword = passwordEncoder.encode(password);

        // room 만들기
        Room room = Room.builder()
                .manager(me)
                .name(name)
                .distance(distance)
                .status(Status.WAITING)
                .password(hashedPassword)
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

        if (savedRoom.getRoomMembers() == null) {
            savedRoom.setRoomMembers(new ArrayList<>());
        }

        savedRoom.getRoomMembers().add(roomMember);

        // stomp 통신을 위한 uuid
        UUID uuid = UUID.randomUUID();
        redisTemplate.opsForValue().set("uuid_roomId:" + savedRoom.getId(), uuid.toString()); // redis에 uuid 저장

        // socket으로 방의 멤버(자기 자신밖에 없다)들의 리스트를 보내준다
        List<MemberResDto> memberResDtos = savedRoom.getRoomMembers().stream().map(RoomMember::toMemberResDto).toList();
        StompResDto stompResDto = StompResDto.builder()
                .action("member").data(memberResDtos).build();
        messagingTemplate.convertAndSend("/topic/room/" + uuid, stompResDto);

        // postRoomResDto 돌려주기
        PostRoomResDto postRoomResDto = savedRoom.toPostRoomResDto();


        postRoomResDto.setUuid(uuid);

        return postRoomResDto;

    }

    @Transactional(readOnly = true)
    public RoomScrollResDto getRooms(Long lastId, int pageSize, String searchWord, boolean isSecret) { // 모든 방 가져오기
        if (searchWord == null) searchWord = "";

        Slice<RoomResDto> roomResDtos = roomRepository.findAll(lastId, pageSize, searchWord, isSecret);

        return new RoomScrollResDto(roomResDtos.getContent(), roomResDtos.hasNext());
    }

    @Transactional
    public PatchRoomResDto patchRoomName(Long roomId, PatchRoomNameReqDto patchRoomNameReqDto) {
        // 요청자가 방장인지 확인한다
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));

        if (!myMemberId.equals(room.getManager().getId())) {
            throw new NotManagerException(HttpStatus.BAD_REQUEST, myMemberId + "는 " + roomId + "의 방장이 아닙니다");
        }

        String name = patchRoomNameReqDto.getName();
        room.patchRoomName(name);

        // 방의 유저들에게 바뀐 이름을 socket으로 알려준다
//        List<RoomMember> roomMembers = room.getRoomMembers();
//
//        for (RoomMember roomMember: roomMembers) {
//            messagingTemplate.convertAndSend("/member/private/" + roomMember.getMember().getId(), patchRoomNameReqDto);
//        }

        return PatchRoomResDto.builder()
                .roomId(roomId)
                .build();

    }

    @Transactional
    public PatchRoomResDto patchRoomDistance(Long roomId, PatchRoomDistanceReqDto patchRoomDistanceReqDto) {
        // 요청자가 방장인지 확인한다
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));

        if (!myMemberId.equals(room.getManager().getId())) {
            throw new NotManagerException(HttpStatus.BAD_REQUEST, myMemberId + "는 " + roomId + "의 방장이 아닙니다");
        }

        double distance = patchRoomDistanceReqDto.getDistance();

        room.patchRoomDistance(distance);

        // 방의 유저들에게 바뀐 거리를 socket으로 알려준다
//        List<RoomMember> roomMembers = room.getRoomMembers();
//
//        for (RoomMember roomMember: roomMembers) {
//            messagingTemplate.convertAndSend("/member/private/" + roomMember.getMember().getId(), patchRoomDistanceReqDto);
//        }

        return PatchRoomResDto.builder()
                .roomId(roomId)
                .build();

    }

    @Transactional
    public PatchRoomResDto patchRoomPassword(Long roomId, PatchRoomPasswordReqDto patchRoomPasswordReqDto) {
        // 요청자가 방장인지 확인한다
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));

        if (!myMemberId.equals(room.getManager().getId())) {
            throw new NotManagerException(HttpStatus.BAD_REQUEST, myMemberId + "는 " + roomId + "의 방장이 아닙니다");
        }

        String password = patchRoomPasswordReqDto.getPassword();
        // 방 비밀번호 hashing
        String hashedPassword = passwordEncoder.encode(password);

        room.patchRoomPassword(hashedPassword);

        return PatchRoomResDto.builder()
                .roomId(roomId)
                .build();

    }

    @Transactional
    public PatchRoomResDto patchRoomCapacity(Long roomId, PatchRoomCapacityReqDto patchRoomCapacityReqDto) {
        // 요청자가 방장인지 확인한다
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));

        if (!myMemberId.equals(room.getManager().getId())) {
            throw new NotManagerException(HttpStatus.BAD_REQUEST, myMemberId + "는 " + roomId + "의 방장이 아닙니다");
        }

        int capacity = patchRoomCapacityReqDto.getCapacity();

        room.patchRoomCapacity(capacity);

        // 방의 유저들에게 바뀐 정원을 socket으로 알려준다
//        List<RoomMember> roomMembers = room.getRoomMembers();
//
//        for (RoomMember roomMember: roomMembers) {
//            messagingTemplate.convertAndSend("/member/private/" + roomMember.getMember().getId(), patchRoomCapacityReqDto);
//        }

        return PatchRoomResDto.builder()
                .roomId(roomId)
                .build();
    }

    @Transactional
    public RoomMemberResDto enterRoom(Long roomId, String password) {
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        Member me =  memberRepository.findById(myMemberId).orElseThrow(MemberNotFoundException::new);

        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));
        Optional<RoomMember> roomMember = roomMemberRepository.findByRoomIdAndMemberId(roomId, myMemberId);
        // 이미 입장해 있다면 에러 발생
        if (roomMember.isPresent()) {
            throw new RoomMemberExistsException(HttpStatus.CONFLICT, roomId + "를 방 id로, " + myMemberId +"를 memberId로 지닌 roomMember가 존재합니다");
        }
        // 게임이 진행 중이라면 에러 발생 TODO 재입장인 경우 수정 필요:
        if (room.getStatus().name().equals("IN_PROGRESS")) throw new CustomException(HttpStatus.NOT_MODIFIED, room.getId() + "방은 게임이 진행 중이므로 입장할 수 없습니다");

        // 비밀방이라면 비밀번호가 일치해야 한다
        if (password != null) {
            if (!passwordEncoder.matches(password, room.getPassword())) {
                throw new CustomException(HttpStatus.BAD_REQUEST, roomId +"방의 비밀번호가 일치하지 않습니다");
            }
        }

        // roomMember 만들기
        RoomMember toSaveRoomMember = RoomMember.builder()
                .room(room)
                .member(me)
                .isReady(false)
                .build();

        RoomMember savedRoomMember = roomMemberRepository.save(toSaveRoomMember);

        // room 업데이트
        room.getRoomMembers().add(savedRoomMember);

        // 방의 유저들에게 유저들의 리스트를 보내준다.
        List<MemberResDto> memberResDtos = room.getRoomMembers().stream().map(RoomMember::toMemberResDto).toList();
        // 방장 선택
        for (MemberResDto m: memberResDtos) {
            if (m.getMemberId().equals(room.getManager().getId())) {
                m.setManager();
            }
        }

        UUID uuid =  UUID.fromString(Objects.requireNonNull(redisTemplate.opsForValue().get("uuid_roomId:" + room.getId())));

        StompResDto stompResDto = StompResDto.builder()
                        .action("member").data(memberResDtos).build();
        messagingTemplate.convertAndSend("/topic/room/" + uuid, stompResDto);

        return RoomMemberResDto.builder().roomMemberId(savedRoomMember.getId()).uuid(uuid).build();

    }

    @Transactional
    public RoomMemberResDto readyRoom(Long roomId) {
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        Member me =  memberRepository.findById(myMemberId).orElseThrow(MemberNotFoundException::new);

        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));
        Optional<RoomMember> roomMemberOptional = roomMemberRepository.findByRoomIdAndMemberId(roomId, myMemberId);

        if (roomMemberOptional.isEmpty()) {
            throw new RoomMemberNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 방 id로, " + myMemberId +"를 memberId로 지닌 roomMember가 존재하지 않습니다");
        }

       RoomMember roomMember = roomMemberOptional.get();
       roomMember.setReady();

        List<RoomMember> roomMembers = room.getRoomMembers();
        for (RoomMember r: roomMembers) {
            if (r.getMember().getId().equals(myMemberId)) {
                r.setReady();
            }
        }


        List<MemberResDto> memberResDtos = room.getRoomMembers().stream().map(RoomMember::toMemberResDto).toList();

        String uuid = redisTemplate.opsForValue().get("uuid_roomId:" + roomId);

        // 방의 유저들에게 유저들의 리스트를 socket으로 알려준다
        StompResDto stompResDto = StompResDto.builder()
                .action("member").data(memberResDtos).build();
        messagingTemplate.convertAndSend("/topic/room/" + uuid, stompResDto);

        return RoomMemberResDto.builder().roomMemberId(roomMember.getId()).build();

    }

    @Transactional
    public RoomMemberResDto exitRoom(Long roomId) {
        Long myMemberId = SecurityUtil.getCurrentMemberId();
        Member me =  memberRepository.findById(myMemberId).orElseThrow(MemberNotFoundException::new);

        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));
        Optional<RoomMember> roomMemberOptional = roomMemberRepository.findByRoomIdAndMemberId(roomId, myMemberId);
        // 입장해 있지 않다면 error 발생
        if (roomMemberOptional.isEmpty()) {
            throw new RoomMemberNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 방 id로, " + myMemberId +"를 memberId로 지닌 roomMember가 존재하지 않습니다");
        }

        // roomMember 삭제
        roomMemberRepository.deleteById(roomMemberOptional.get().getId());

        List<RoomMember> roomMembers = room.getRoomMembers();
        roomMembers.remove(roomMemberOptional.get());

        // 내가 방장이고 방을 나갔을 경우
        // 남은 사람이 아무도 없는 경우: 방을 제거한다
        // 남은 사람이 1명 이상인 경우: 방장을 변경한다:
        if (room.getManager().getId().equals(myMemberId)) {
            if (roomMembers.isEmpty()) removeRoom(roomId);
            else {
                roomMembers.sort((r1, r2) -> r1.getCreatedAt().compareTo(r2.getCreatedAt()));
                room.setManager(roomMembers.get(0).getMember());
            }
        }

        // socket으로 방의 멤버들에게 멤버들의 리스트를 보내준다
        if (!roomMembers.isEmpty()) {
            List<MemberResDto> memberResDtos = roomMembers.stream().map(RoomMember::toMemberResDto).toList();
            memberResDtos.get(0).setManager();

            StompResDto stompResDto = StompResDto.builder()
                    .action("member").data(memberResDtos).build();

            String uuid = redisTemplate.opsForValue().get("uuid_roomId:" + roomId);

            messagingTemplate.convertAndSend("/topic/room/" + uuid, stompResDto);
        }

        return RoomMemberResDto.builder().roomMemberId(roomMemberOptional.get().getId()).build();

    }

    @Transactional
    public void removeRoom(Long roomId) { // 방 삭제
        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));

        redisTemplate.delete("uuid_roomId:" + roomId); // uuid 삭제

        roomRepository.deleteById(room.getId());

    }

    @Transactional
    public void startGame(Long roomId) { // 단체전 방의 게임을 시작
        // 요청자가 방장인지 확인한다
        Long myMemberId = SecurityUtil.getCurrentMemberId();

        Room room = roomRepository.findById(roomId).orElseThrow(() -> new RoomNotFoundException(HttpStatus.NOT_FOUND, roomId + "를 id로 가진 방이 존재하지 않습니다"));

        if (!myMemberId.equals(room.getManager().getId())) {
            throw new NotManagerException(HttpStatus.BAD_REQUEST, myMemberId + "는 " + roomId + "의 방장이 아닙니다");
        }

        // 단체전 방의 게임이 시작될 수 있는지 확인한다: 그렇지 않다면 에러 발생
        List<RoomMember> roomMembers = room.getRoomMembers();
        for (RoomMember r: roomMembers) {
            if (!r.getIsReady()) throw new CustomException(HttpStatus.BAD_REQUEST, roomId + "를 id로 지닌 방은 게임을 시작할 수 없습니다: "  + r.getMember().getId() + "님이 게임 준비를 하지 않았습니다" );
        }

        // status 변경한다
        room.startGame();

        // socket으로 모든 유저들에게 단체전이 시작되었음을 알려준다
        StompResDto stompResDto = StompResDto.builder()
                        .action("start").data(null).build();
        messagingTemplate.convertAndSend("/topic/room/" + roomId, stompResDto);

    }



}
