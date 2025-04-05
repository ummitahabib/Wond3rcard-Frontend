import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;
import 'package:wond3rcard/src/cards/data/model/create_card/create_card_model.dart';
import 'package:wond3rcard/src/cards/data/repository/create_card_repository.dart';

import '../repository/card_repository.dart';

final createCardControllerProvider =
    StateNotifierProvider<CreateCardController, AsyncValue<void>>((ref) {
  final repository = ref.watch(createCardRepositoryProvider);
  return CreateCardController(repository);
});

class CreateCardController extends StateNotifier<AsyncValue<void>> {
  final CreateCardRepository _repository;

  CreateCardController(this._repository) : super(const AsyncValue.data(null));

  /// Picks an image for mobile
  Future<File?> pickImage(ImageSource source) async {
    if (kIsWeb) return null; // Use pickWebImage() for web
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  /// Picks an image for Web
  Future<Uint8List?> pickWebImage() async {
    final completer = Completer<Uint8List?>();
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        completer.complete(reader.result as Uint8List);
      });
    });

    return completer.future;
  }

  /// Creates a new card
  Future<void> createCard(CreateCardModel card) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createCard(card);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
