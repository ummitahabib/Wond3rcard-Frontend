import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wond3rcard/src/subscription/data/model/subscription_model.dart';

class SubscriptionRepository {
  final String baseUrl;

  SubscriptionRepository({required this.baseUrl});

  Future<SubscriptionResponse> createSubscription(
      SubscriptionRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/subscribe'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return SubscriptionResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create subscription');
    }
  }
}
