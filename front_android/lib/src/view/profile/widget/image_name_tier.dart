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
          Container(
            decoration: BoxDecoration(
              color: ref.color.profileEditButtonBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.network(
              characterImgUrl,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
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
