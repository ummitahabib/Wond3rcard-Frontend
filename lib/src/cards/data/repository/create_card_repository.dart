import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:wond3rcard/src/cards/data/model/create_card/create_card_model.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';

// class CreateCardRepository {
//   final Dio _dio = Dio();

//   Future<void> createCard(CreateCardModel card) async {
//     final String? authToken = StorageUtil.getString(key: SessionString.accessTokenString);
//     try {
//       FormData formData = FormData.fromMap({
//         "cardType": card.cardType,
//         "ownerId": card.ownerId,
//         "cardName": card.cardName,
//         "suffix": card.suffix,
//         "firstName": card.firstName,
//         "lastName": card.lastName,
//         "email": card.email,
//         "phone": card.phone,
//         "website": card.website,
//         "address": card.address,
//         "socialMediaLinks": card.socialMediaLinks,
//         if (!kIsWeb && card.cardPhoto != null)
//           "cardPhoto": await MultipartFile.fromFile(card.cardPhoto!.path),
//         if (kIsWeb && card.cardPhoto != null)
//           "cardPhoto": MultipartFile.fromBytes(card.cardPhoto as Uint8List, filename: "image.png"),
//       });

//       Response response = await _dio.put(
//         getUrl(Endpoints.createCard),
//         data: formData,
//         options: Options(
//           headers: {
//             "Content-Type": "multipart/form-data",
//             "Authorization": "Bearer $authToken", // Adding Authorization Token
//           },
//         ),
//       );

//       print("Card created successfully: ${response.data}");
//     } catch (e) {
//       print("Error creating card: $e");
//       throw e;
//     }
//   }
// }

// // Provider for repository
// final CreateCardRepositoryProvider = Provider((ref) => CreateCardRepository());






class CreateCardRepository {
  final Dio _dio = Dio();

  Future<void> createCard(CreateCardModel cardModel) async {
    try {
       final String? authToken = StorageUtil.getString(key: SessionString.accessTokenString);
      // ✅ Correctly Handle Image Uploads for Mobile & Web
      MultipartFile? cardPhoto;
      MultipartFile? cardCoverPhoto;

      // 🔹 Mobile: Use File Path
      if (!kIsWeb) {
        if (cardModel.cardPhoto != null) {
          cardPhoto = await MultipartFile.fromFile(
            cardModel.cardPhoto!.path,
            contentType: MediaType.parse(lookupMimeType(cardModel.cardPhoto!.path) ?? 'image/jpeg'),
          );
        }
        if (cardModel.cardCoverPhoto != null) {
          cardCoverPhoto = await MultipartFile.fromFile(
            cardModel.cardCoverPhoto!.path,
            contentType: MediaType.parse(lookupMimeType(cardModel.cardCoverPhoto!.path) ?? 'image/jpeg'),
          );
        }
      } 
      // 🔹 Web: Use Uint8List
      else {
        if (cardModel.webCardPhoto != null) {
          cardPhoto = MultipartFile.fromBytes(
            cardModel.webCardPhoto!,
            contentType: MediaType.parse('image/jpeg'), // Default to JPEG
            filename: "card_photo.jpg",
          );
        }
        if (cardModel.webCardCoverPhoto != null) {
          cardCoverPhoto = MultipartFile.fromBytes(
            cardModel.webCardCoverPhoto!,
            contentType: MediaType.parse('image/jpeg'), // Default to JPEG
            filename: "card_cover.jpg",
          );
        }
      }

      // ✅ Correctly format formData
      FormData formData = FormData.fromMap({
        "cardType": cardModel.cardType,
        "ownerId": cardModel.ownerId,
        "cardName": cardModel.cardName,
        "suffix": cardModel.suffix,
        "firstName": cardModel.firstName,
        "lastName": cardModel.lastName,
        "middleName": cardModel.middleName,
        "dateOfBirth": cardModel.dateOfBirth,
        "designation": cardModel.designation,
        "notes": cardModel.notes,
        "primaryColor": cardModel.primaryColor,
        "secondaryColor": cardModel.secondaryColor,
        "fontSize": cardModel.fontSize,
        "fontWeight": cardModel.fontWeight,
        "fontStyle": cardModel.fontStyle,
        "fontFamilyName": cardModel.fontFamilyName,
        "organizationId": cardModel.organizationId,
        "email": cardModel.email,
        "phone": cardModel.phone,
        "website": cardModel.website,
        "address": cardModel.address,
        "socialMediaLinks": cardModel.socialMediaLinks,
        "textColor": cardModel.textColor,
        "cardPhoto": cardPhoto,
        "cardCoverPhoto": cardCoverPhoto,
      });

      // ✅ Correctly add Authorization Token
      Response response = await _dio.put(
      getUrl(Endpoints.createCard),
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $authToken",
          },
        ),
      );

      print("✅ Card Created Successfully: ${response.data}");
    } catch (e) {
      print("❌ Error creating card: $e");
      rethrow;
    }
  }
}
final createCardRepositoryProvider = Provider((ref) => CreateCardRepository());
