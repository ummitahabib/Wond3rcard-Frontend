import 'package:dio/dio.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/model/admin_manual_payment_model.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/model/get_all_transaction_record.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/model/get_manual_transaction.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/model/payment_analytics_model.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';

class PaymentRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl));

  // Manual Payment
  Future<ManualPaymentResponse> createManualPayment(ManualPaymentRequest request) async {
    try {
      final response = await _dio.post(
        "manual-payment/initialize-payment",
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return ManualPaymentResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to create manual payment");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }


    Future<List<Transaction>> getTransactionsByProvider(String provider) async {
    try {
      final response = await _dio.get("payment/transactions?provider=manual", queryParameters: {
        "provider": provider,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['payload'];
        return data.map((json) => Transaction.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch transactions");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }



   Future<List<TransactionRecord>> getTransactions({
    String? provider,
    String? status,
    String? plan,
    String? billingCycle,
    String? paymentMethod,
    String? transactionId,
    String? referenceId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final response = await _dio.get("payments/transactions", queryParameters: {
        "provider": provider,
        "status": status,
        "plan": plan,
        "billingCycle": billingCycle,
        "paymentMethod": paymentMethod,
        "transactionId": transactionId,
        "referenceId": referenceId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['payload'];
        return data.map((json) => TransactionRecord.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch transactions");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }


    Future<PaymentAnalytics> getPaymentAnalytics() async {
    try {
      final response = await _dio.get('payments/analytics');

      if (response.statusCode == 200) {
        return PaymentAnalytics.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch payment analytics");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}



