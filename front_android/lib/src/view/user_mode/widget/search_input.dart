import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class SearchInput extends ConsumerWidget {
  const SearchInput({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.current.EnterSearchTerm,
            style: ref.typo.body2.copyWith(
              color: ref.color.inactive,
            ),
          ),
          TextField(
            onSubmitted: (value) {
              onSubmit();
            },
            controller: controller,
            cursorColor: ref.color.onBackground,
            style: ref.typo.subTitle1.copyWith(
              color: ref.color.onBackground,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ref.color.onBackground,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ref.color.accept,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: ref.color.onBackground),
                onPressed: () => onSubmit(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
