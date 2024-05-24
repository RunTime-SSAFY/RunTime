import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/user_mode/user_mode_view_model.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class TagButton extends ConsumerWidget {
  const TagButton({
    super.key,
    required this.tagName,
  });

  final String tagName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModeViewModel viewModel = ref.watch(userModeViewModelProvider);
    return GestureDetector(
      onTap: () {
        viewModel.changeTag(tagName);
      },
      child: Semantics(
        button: true,
        label: S.current.semanticsButton,
        hint: '$tagName ${S.current.search}',
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 100,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            color: viewModel.tagNow == tagName
                ? ref.color.accept
                : ref.palette.gray700,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              tagName,
              style: ref.typo.headline2.copyWith(
                fontSize: 18,
                color: viewModel.tagNow == tagName
                    ? ref.color.onAccept
                    : ref.color.onInactive,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TagButtonList extends StatelessWidget {
  const TagButtonList({
    super.key,
    required this.tagNameList,
  });

  final List<String> tagNameList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagNameList.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(
            left: index == 0 ? 20 : 5,
            right: index == tagNameList.length - 1 ? 20 : 5,
          ),
          child: TagButton(
            tagName: tagNameList[index],
          ),
        ),
      ),
    );
  }
}
