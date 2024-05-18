import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class ParticipantsCartGrid extends ConsumerWidget {
  const ParticipantsCartGrid({
    super.key,
    required this.participants,
  });

  final List<Participant> participants;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: participants.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ref.color.userModeBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  participants[index].characterImgUrl,
                  fit: BoxFit.contain,
                  height: 110,
                  width: 110,
                ),
                Text(
                  participants[index].nickname,
                  style: participants[index].nickname.length <= 5
                      ? ref.typo.headline1.copyWith(
                          color: ref.color.onBackground,
                        )
                      : ref.typo.headline4.copyWith(
                          color: ref.color.onBackground,
                        ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: participants[index].isManager
                        ? ref.color.onBackground
                        : participants[index].isReady
                            ? ref.color.battleBackground2
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    participants[index].isManager
                        ? S.current.manager
                        : participants[index].isReady
                            ? S.current.ready
                            : '',
                    style: ref.typo.headline4.copyWith(
                      color: participants[index].isManager
                          ? ref.color.text
                          : ref.color.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
