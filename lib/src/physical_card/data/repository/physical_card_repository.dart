import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/model/physical_card_model.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';

class PhysicalCardRepository {
  final Dio dio;

  PhysicalCardRepository(this.dio);

  Future<PhysicalCardModel> createPhysicalCard({
    required String userId,
    required String cardId,
    required String templateId,
    required String primaryColor,
    required String secondaryColor,
    required String finalDesign,
  }) async {
    final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final response = await dio.post(
      'phy-cards/create-physical-card',
      data: {
        'userId': userId,
        'cardId': cardId,
        'templateId': templateId,
        'primaryColor': primaryColor,
        'secondaryColor': secondaryColor,
        'finalDesign': finalDesign,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    return PhysicalCardModel.fromJson(response.data['payload']);
  }










  Future<List<PhysicalCardModel>> getPhysicalCards() async {
    final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final response = await dio.get('phy-cards/physical-cards',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ));
    final List data = response.data['payload'];
    return data.map((e) => PhysicalCardModel.fromJson(e)).toList();
  }

  Future<List<PhysicalCardModel>> getPhysicalCardsByUserId(
      String userId) async {
    final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final response = await dio.get('phy-cards/physical/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ));
    final List data = response.data['payload'];
    return data.map((e) => PhysicalCardModel.fromJson(e)).toList();
  }

  Future<List<PhysicalCardModel>> getPhysicalCardsByCardId(
      String cardId) async {
    final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final response = await dio.get('phy-cards/physical/$cardId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ));
    final List data = response.data['payload'];
    return data.map((e) => PhysicalCardModel.fromJson(e)).toList();
  }

  Future<String> deletePhysicalCard({required String cardId}) async {
    final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final response = await dio.delete(
      'phy-cards/delete-physical-card/:$cardId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response.data['message'];
  }
}

final physicalCardRepositoryProvider = Provider<PhysicalCardRepository>((ref) {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://wond3rcard-backend.onrender.com/api/'));
  return PhysicalCardRepository(dio);
});
