// order_physical_card_repository.dart
import 'package:dio/dio.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';

class OrderPhysicalCardRepository {
  final Dio dio;

  OrderPhysicalCardRepository(this.dio);

  Future<Map<String, dynamic>> createOrder({
    required String userId,
    required String physicalCardId,
    required String cardTemplateId,
    required int quantity,
    required String region,
    required String address,
  }) async {
     final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final response = await dio.post(
      'https://wond3rcard-backend.onrender.com/api/card-orders/create',
      data: {
        "userId": userId,
        "physicalCardId": physicalCardId,
        "cardTemplateId": cardTemplateId,
        "quantity": quantity,
        "region": region,
        "address": address,
      },
      options: Options(
       headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
      ),
    );

    if (response.statusCode == 201) {
      return response.data['payload'];
    } else {
      throw Exception(response.data['message'] ?? 'Failed to create order');
    }
  }



  Future<List<Map<String, dynamic>>> getOrderByUserId(String userId) async {
     final token = StorageUtil.getString(key: SessionString.accessTokenString);

  final response = await dio.get(
    'https://wond3rcard-backend.onrender.com/api/card-orders/user/:$userId/orders',
  options: Options(
       headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
      ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = response.data['payload'];
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception(response.data['message'] ?? 'Failed to fetch orders');
  }
}



  Future<Map<String, dynamic>> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      final response = await dio.patch(
        '/orders/$orderId/status',
        data: {'status': status},
      );

      if (response.statusCode == 200) {
        return response.data['payload'];
      } else {
        throw Exception('Failed to update order status');
      }
    } catch (e) {
      throw Exception('Error updating order: $e');
    }
  }
}
