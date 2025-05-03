import 'package:dio/dio.dart';
import 'package:wond3rcard/src/physical_card/data/model/custom_card_model.dart';
import 'package:wond3rcard/src/utils/util.dart';

class CustomCardRepository {
  final Dio dio;

  CustomCardRepository(this.dio);

  Future<CustomCardModel> createCustomCard({
    required String name,
    required String priceNaira,
    required String priceUsd,
  }) async {
       final String? token =
        StorageUtil.getString(key: SessionString.accessTokenString);
    final response = await dio.post(
      'phy-cards/create-custom-template',
      options: Options(
        headers: {
           'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        'name': name,
        'priceNaira': priceNaira,
        'priceUsd': priceUsd,
      },
    );

    return CustomCardModel.fromJson(response.data['payload']);
  }




    Future<CustomCardModel> updateCustomCard({
    required String templateId,
    required String name,
    required String priceNaira,
    required String priceUsd,
  }) async {
    final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final response = await dio.patch(
      '/phy-cards/update-template/$templateId',
      data: {
        'name': name,
        'priceNaira': priceNaira,
        'priceUsd': priceUsd,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    return CustomCardModel.fromJson(response.data['payload']);
  }
}
