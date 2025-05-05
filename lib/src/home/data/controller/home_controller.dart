import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';

final homeProvider = ChangeNotifierProvider<HomeNotifier>((ref) {
  return HomeNotifier();
});

class HomeNotifier extends ChangeNotifier {
  HomeNotifier();

  bool? _isActive;
  int _activeIndex = SpacingConstants.int0;

  bool? get isActive => _isActive;

  set isActive(bool? value) {
    if (_isActive != value) {
      _isActive = value;
      notifyListeners();
    }
  }

  int get activeIndex => _activeIndex;

  void setActiveIndex(int index) {
    if (_activeIndex != index) {
      _activeIndex = index;
      notifyListeners();
    }
  }
}
