import 'package:flutter/material.dart';

interface class Typo {
  const Typo({
    required this.name,
    required this.regular,
    required this.semiBold,
    required this.bold,
  });

  final String name;
  final FontWeight regular;
  final FontWeight semiBold;
  final FontWeight bold;
}

class MyTypo implements Typo {
  const MyTypo();

  @override
  final String name = 'noto_sans';

  @override
  final FontWeight regular = FontWeight.normal;

  @override
  final FontWeight semiBold = FontWeight.w600;

  @override
  final FontWeight bold = FontWeight.bold;
}
