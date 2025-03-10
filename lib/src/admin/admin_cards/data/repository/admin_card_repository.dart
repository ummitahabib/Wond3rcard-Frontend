import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:wond3rcard/src/admin/admin_cards/data/model/admin_card_model.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final cardRepositoryProvider = Provider<CardRepository>((ref) {
  return CardRepository();
});

class CardRepository {
  Future<List<CardModel>> fetchCards() async {
             final String token = SessionString.accessTokenString;
    try {
        final response = await http.get(
       headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      Uri.parse(getUrl(Endpoints.getallUsersCard),));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          return CardModel.fromPayload(data['payload']);
        } else {
          throw Exception("Failed to fetch users: ${data['message']}");
        }
      } else {
        throw Exception("Error fetching users: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
