import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/fonts/data/model/font_model.dart';
import 'package:wond3rcard/src/admin/fonts/data/repository/font_repository.dart';
import 'package:wond3rcard/src/utils/alert.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final fontProvider = ChangeNotifierProvider<FontNotifier>((ref) {
  return FontNotifier(ref);
});

class FontNotifier extends ChangeNotifier {
  final Ref ref;

  FontNotifier(this.ref);

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }

  late Font _font;

  Font get font => _font;

  set font(Font fontModel) {
    _font = fontModel;
    notifyListeners();
  }

  List<Font> _fonts = [];

  List<Font> get fonts => _fonts;

  set fonts(List<Font> fontList) {
    _fonts = fontList;
    notifyListeners();
  }

  TextEditingController fontName = TextEditingController();

  Future<bool> uploadFont(BuildContext context) async {
    final String name = fontName.text;

    if (name.isEmpty) {
      alert.showErrorToast(message: "All fields are required.");
      return false;
    }

    final Font font = Font(
      name: name,
    );

    try {
      loading = true;

      final response = await ref.read(fontRepositoryProvider).uploadFont(font);

      loading = false;

      if (response.hasError()) {
        alert.showErrorToast(
            message: response.error?.message ?? "Failed to upload font");
        return false;
      } else {
        alert.showSuccessToast(message: "font uploaded succesfully");

        return true;
      }
    } catch (e) {
      loading = false;
      alert.showErrorToast(message: "An unexpected error occurred.");
      return false;
    }
  }

  Future<Font> getAllFonts(BuildContext context) async {
    try {
      loading = true;
      final response = await ref.watch(fontRepositoryProvider).getAllFonts();
      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        loading = false;
      } else {
        _font = response.response;
        font = _font;
        return font;
      }
    } catch (e) {
      alert.showErrorToast(message: 'an error occured ');
      print(e);
      return font;
    }
    return font;
  }

  Future<bool> updateFont(BuildContext context) async {
    final String name = fontName.text;
    String fontId = '';
    if (name.isEmpty) {
      alert.showErrorToast(message: "All fields are required.");
      return false;
    }

    final Font font = Font(
      name: name,
      id: fontId,
    );

    try {
      loading = true;

      final response = await ref.read(fontRepositoryProvider).updateFont(font);

      loading = false;

      if (response.hasError()) {
        alert.showErrorToast(
            message: response.error?.message ?? "Failed to upload font");
        return false;
      } else {
        alert.showSuccessToast(message: "font uploaded succesfully");

        return true;
      }
    } catch (e) {
      loading = false;
      alert.showErrorToast(message: "An unexpected error occurred.");
      return false;
    }
  }

  Future<bool> deleteFont() async {
    const String id = '';
    try {
      loading = true;

      final response = await ref.watch(fontRepositoryProvider).deleteFont(id);

      if (response.hasError()) {
        loading = false;
        alert.showErrorToast(message: response.error?.message ?? emptyString);
      } else {
        loading = false;
        alert.showSuccessToast(message: 'font deleted successful');
      }
    } catch (e) {
      print(e);
      alert.showErrorToast(message: e.toString());
      return false;
    }
    return false;
  }
}
