import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/model/physical_card_template_model.dart';

class CardState {
  final Uint8List? imageBytes;
  final int selectedIndex;
  final CardTemplateModel? selectedTemplate;
  final int quantity;

  CardState({
    this.imageBytes,
    this.selectedIndex = 0,
    this.selectedTemplate,
    this.quantity = 1,
  });

  CardState copyWith({
    Uint8List? imageBytes,
    int? selectedIndex,
    CardTemplateModel? selectedTemplate,
    int? quantity,
  }) {
    return CardState(
      imageBytes: imageBytes ?? this.imageBytes,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedTemplate: selectedTemplate ?? this.selectedTemplate,
      quantity: quantity ?? this.quantity,
    );
  }
}

class OrderPhysicalCardController extends StateNotifier<CardState> {
  OrderPhysicalCardController() : super(CardState());


 
  void setQuantity(int quantity) {
    state = state.copyWith(quantity: quantity);
  }


  void setImageBytes(Uint8List? bytes) {
    state = state.copyWith(imageBytes: bytes);
  }

  void setSelectedIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  void setSelectedTemplate(CardTemplateModel template) {
    state = state.copyWith(selectedTemplate: template);
  }

  void incrementQuantity() {
    state = state.copyWith(quantity: state.quantity + 1);
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      state = state.copyWith(quantity: state.quantity - 1);
    }
  }
}

final physicalCardProvider =
    StateNotifierProvider<OrderPhysicalCardController, CardState>((ref) {
  return OrderPhysicalCardController();
});
