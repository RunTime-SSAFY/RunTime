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

class Pretendard implements Typo {
  const Pretendard();

  @override
  final String name = 'Pretendard';

  @override
  final FontWeight regular = FontWeight.w400;

  @override
  final FontWeight semiBold = FontWeight.w600;

  @override
  final FontWeight bold = FontWeight.w700;
}
