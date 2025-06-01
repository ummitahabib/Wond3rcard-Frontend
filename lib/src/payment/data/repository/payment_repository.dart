import 'package:dio/dio.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/payment/data/model/payment_model.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';

class UserPaymentRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl));

  Future<PaymentResponseModel> payWithPaystack(PaymentRequestModel data) async {
    final String? token =
        StorageUtil.getString(key: SessionString.accessTokenString);
    final response = await _dio.post('paystack/initialize-payment',
        data: data.toJson(),
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
          },
        ));
    return PaymentResponseModel.fromJson(response.data);
  }

  Future<PaymentResponseModel> payWithStripe(PaymentRequestModel data) async {
    final String? token =
        StorageUtil.getString(key: SessionString.accessTokenString);
    final response = await _dio.post('stripe/initialize-payment',
        data: data.toJson(),
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
          },
        ));
    return PaymentResponseModel.fromJson(response.data);
  }

  Future<bool> verifyTransaction(String reference) async {
    final response = await _dio.get('/payment/verify/$reference');
    return response.data['status'] == 'success';
  }
}
