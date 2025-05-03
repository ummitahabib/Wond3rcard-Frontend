import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/cards/data/model/getCard/get_card_model.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';







class GetCardRepository {
  final Dio _dio = Dio();

  Future<GetCardModel?> getCard() async {
      final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      Response response = await _dio.get(
              getUrl(Endpoints.getallUsersCard),
        options: Options(
          headers: {
            "Authorization": "Bearer $authToken",
          },
        ),
      );

      // ✅ Debugging: Print the API Response
      print("✅ Raw API Response: ${response.data}");

      if (response.statusCode == 200) {
        final cardJson = response.data['payload']['card'];
        print("✅ Parsed Card Data: $cardJson"); // Debug JSON Structure
        return GetCardModel.fromJson(cardJson);
      } else {
        print("❌ Failed to fetch card: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error fetching card: $e");
      return null;
    }
  }
}

final getCardRepositoryProvider = Provider<GetCardRepository>((ref) => GetCardRepository());
