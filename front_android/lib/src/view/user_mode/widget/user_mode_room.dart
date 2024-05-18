import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class UserModeRoomCard extends ConsumerWidget {
  const UserModeRoomCard({
    required this.room,
    super.key,
  });

  final UserModeRoom room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var status = room.status == UserModeRoomStatusHelper.waiting
        ? S.current.waiting
        : S.current.inProgress;

    return GestureDetector(
      onTapUp: (details) {
        context.push(
          RoutePathHelper.waitingRoomWithId(room.roomId),
          extra: {
            'isManager': false,
            'roomData': room,
          },
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
                Row(
                  children: [
                    Text(
                      '${room.name}  ',
                      style: ref.typo.bigRegular.copyWith(
                        color: ref.color.onBackground,
                      ),
                    ),
                    if (room.isSecret)
                      Icon(
                        Icons.lock,
                        color: ref.color.onBackground,
                        size: 20,
                      ),
                  ],
                ),
                Text(
                  '${room.distance ~/ 1000}km',
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
    required this.canFetchMore,
    required this.getRoomList,
  });

  final List<UserModeRoom> userModeRoomList;
  final bool canFetchMore;
  final void Function() getRoomList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent &&
            canFetchMore) {
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
