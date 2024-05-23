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
              color: ref.palette.gray200,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(5),
            child: Image.network(
              characterImgUrl,
              height: 45,
              width: 45,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            alignment: Alignment.centerRight,
            children: [
              // 티어 이미지
              Image.network(
                tierImgUrl,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              // 닉네임
              Padding(
                padding: const EdgeInsets.only(right: 44),
                child: Text(
                  textAlign: TextAlign.right,
                  name,
                  style: ref.typo.headline1.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
