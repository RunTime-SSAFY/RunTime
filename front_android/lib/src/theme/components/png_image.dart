import 'package:flutter/material.dart';

class PngImage extends StatelessWidget {
  const PngImage({
    required this.image,
    this.size,
    super.key,
  });

  final String image;
  final double? size;

  @override
  Widget build(BuildContext context) {
    debugPrint('assets/images/$image.png');
    return Image.asset(
      'assets/images/$image.png',
      fit: BoxFit.contain,
      height: size,
      width: size,
    );
  }
}
