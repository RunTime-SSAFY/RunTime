import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recordViewModelProvider =
    ChangeNotifierProvider((ref) => RecordViewModel());

class RecordViewModel extends ChangeNotifier {
  // Add your view model properties and methods here

  // Example property
  String _title = '';
  String get title => _title;
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  // Example method
  void updateTitle(String newTitle) {
    title = newTitle;
  }
}
