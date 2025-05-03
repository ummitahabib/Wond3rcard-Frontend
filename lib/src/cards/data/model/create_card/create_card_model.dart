import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

part 'create_card_model.freezed.dart';
part 'create_card_model.g.dart';

class FileConverter implements JsonConverter<File?, String?> {
  const FileConverter();

  @override
  File? fromJson(String? filePath) {
    if (filePath == null || filePath.isEmpty || kIsWeb) return null;
    return File(filePath);
  }

  @override
  String? toJson(File? file) {
    return file?.path;
  }
}

class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    return json != null ? Uint8List.fromList(json) : null;
  }

  @override
  List<int>? toJson(Uint8List? object) {
    return object?.toList();
  }
}

@freezed
class CreateCardModel with _$CreateCardModel {
  factory CreateCardModel({
    required String cardType,
    required String ownerId,
    required String cardName,
    required String suffix,
    required String firstName,
    required String lastName,
    String? middleName,
    String? dateOfBirth,
    String? designation,
    String? notes,
    String? primaryColor,
    String? secondaryColor,
    String? fontSize,
    String? fontWeight,
    String? fontStyle,
    String? fontFamilyName,
    String? organizationId,
    required String email,
    required String phone,
    required String website,
    required String address,
    required List<Map<String, dynamic>> socialMediaLinks,
    String? textColor,
    @FileConverter() File? cardPhoto,
    @FileConverter() File? cardCoverPhoto,
    @FileConverter() File? cardVideo,
    @Uint8ListConverter() Uint8List? webCardPhoto,
    @Uint8ListConverter() Uint8List? webCardCoverPhoto,
  }) = _CreateCardModel;

  factory CreateCardModel.fromJson(Map<String, dynamic> json) =>
      _$CreateCardModelFromJson(json);
}
