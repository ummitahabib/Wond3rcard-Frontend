import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderPhysicalCardController extends StateNotifier<CardState> {
  OrderPhysicalCardController() : super(CardState());

  Uint8List? imageBytes;
  int selectedIndex = 0;

  void setImageBytes(Uint8List? bytes) {
    imageBytes = bytes;
    state = state.copyWith(imageBytes: bytes);
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    state = state.copyWith(selectedIndex: index);
  }
}

class CardState {
  final Uint8List? imageBytes;
  final int selectedIndex;

  CardState({this.imageBytes, this.selectedIndex = 0});

  CardState copyWith({Uint8List? imageBytes, int? selectedIndex}) {
    return CardState(
      imageBytes: imageBytes ?? this.imageBytes,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

final physicalCardProvider = StateNotifierProvider<OrderPhysicalCardController, CardState>((ref) {
  return OrderPhysicalCardController();
});