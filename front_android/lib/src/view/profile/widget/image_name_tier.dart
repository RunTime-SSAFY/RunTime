import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class ImageNameTier extends ConsumerWidget {
  const ImageNameTier({
    super.key,
    required this.characterImgUrl,
    required this.name,
    required this.tierImgUrl,
  });

  final String characterImgUrl;
  final String name;
  final String tierImgUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
        children: [
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              color: ref.color.profileEditButtonBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(5),
            child: Image.network(
              characterImgUrl,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: ref.typo.headline2,
          ),
          Image.network(
            tierImgUrl,
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
