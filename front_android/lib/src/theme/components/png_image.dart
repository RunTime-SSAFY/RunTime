import 'package:flutter/material.dart';

class PngImage extends StatelessWidget {
  const PngImage({
    super.key,
    required this.image,
    this.size,
    this.height,
    this.width,
    BoxFit? fit,
  }) : fit = fit ?? BoxFit.contain;

  final String image;
  final BoxFit? fit;
  final double? size;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    debugPrint('assets/images/$image.png');
    return Image.asset(
      'assets/images/$image.png',
      fit: fit,
      height: height ?? size,
      width: width ?? size,
    );
  }
}
