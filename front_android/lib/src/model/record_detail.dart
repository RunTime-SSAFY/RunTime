import 'package:flutter/material.dart';

class RecordDetail {
  final int recordId;
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color textColor;
  final bool isShowRank;
  final Color rankingColor;

  const RecordDetail({
    required this.recordId,
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.textColor,
    required this.isShowRank,
    required this.rankingColor,
  });

  @override
  String toString() {
    return 'RecordStyle{backgroundColor1: $backgroundColor1, backgroundColor2: $backgroundColor2, textColor: $textColor, isShowRank: $isShowRank, rankingColor: $rankingColor}';
  }
}
