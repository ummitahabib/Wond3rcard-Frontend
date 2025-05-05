import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final adminDashBoardProvider =
    ChangeNotifierProvider<AdminDashBoardNotifier>((ref) {
  return AdminDashBoardNotifier(ref);
});

class AdminDashBoardNotifier extends ChangeNotifier {
  final Ref ref;

  AdminDashBoardNotifier(this.ref);

  int selectedDashBoardItemIndex = 0;

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }

  void changeSelectedDashBoardItemIndex(int value) {
    selectedDashBoardItemIndex = value;
    notifyListeners();
  }
}
