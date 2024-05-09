import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/waiting_room/waiting_room_view.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';

class UserModeRoomCard extends ConsumerWidget {
  const UserModeRoomCard({
    required this.room,
    super.key,
  });

  final UserModeRoom room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var status = room.status == UserModeRoomStatus.WAITING
        ? S.current.waiting
        : S.current.inProgress;

    return GestureDetector(
      onTapUp: (details) {
        Navigator.pushNamed(
          context,
          RoutePath.waitingRoom,
          arguments: WaitingRoomArguments(roomId: room.roomId),
        );
      },
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ref.color.userModeBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  room.name,
                  style: ref.typo.bigRegular.copyWith(
                    color: ref.color.onBackground,
                  ),
                ),
                Text(
                  '${room.distance}km',
                  style: ref.typo.headline1.copyWith(
                    color: ref.color.onBackground,
                  ),
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${room.headcount}/${room.capacity}',
                  style: ref.typo.body1.copyWith(
                    color: ref.color.onBackground,
                  ),
                ),
                Text(
                  status,
                  style: ref.typo.body2.copyWith(
                    color: ref.color.onBackground,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserModeRoomList extends ConsumerWidget {
  const UserModeRoomList({
    super.key,
    required this.userModeRoomList,
    required this.getRoomList,
  });

  final List<UserModeRoom> userModeRoomList;
  final void Function() getRoomList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification &&
            notification.metrics.pixels >=
                notification.metrics.maxScrollExtent) {
          getRoomList();
        }
        return false;
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        itemBuilder: (context, index) {
          return UserModeRoomCard(
            room: userModeRoomList[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: userModeRoomList.length,
      ),
    );
  }
}
