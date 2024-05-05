import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class TagButton extends ConsumerStatefulWidget {
  const TagButton({
    super.key,
    required this.tagName,
  });

  final String tagName;

  @override
  ConsumerState<TagButton> createState() => _TagButtonState();
}

class _TagButtonState extends ConsumerState<TagButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: S.current.semanticsButton,
      hint: '${widget.tagName} ${S.current.search}',
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 500,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        decoration: BoxDecoration(
          color: ref.color.accept,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.tagName,
            style: ref.typo.headline2.copyWith(
              color: ref.color.onAccept,
            ),
          ),
        ),
      ),
    );
  }
}

class TagButtonList extends StatelessWidget {
  const TagButtonList({super.key});

  final List<String> tagNameList = const ['전체', '공개방', '1km', '3km', '5km'];

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
