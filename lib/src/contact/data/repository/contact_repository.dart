import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/contact/data/model/suggested_user.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';

class ContactRepository {
  final Dio _dio;

  ContactRepository(this._dio);
            final String? token =
      StorageUtil.getString(key: SessionString.accessTokenString);
  Future<Map<String, dynamic>> addContact({
    required String userId,
    required String contactEmail,
  }) async {
    try {

      final response = await _dio.post(
        getUrl('profile/$userId/contacts/'),
        data: {
          'contactEmail': contactEmail,
        },
   
        options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        )
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to add contact: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getContacts(String userId) async {
    try {
      final response = await _dio.get(
        getUrl('profile/$userId/contacts/'),
        
        options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        )
      );
      return List<Map<String, dynamic>>.from(response.data['payload']);
    } catch (e) {
      throw Exception('Failed to fetch contacts: $e');
    }
  }

  Future<Map<String, dynamic>> connectWithContact(String contactUserId) async {
    try {
      final response = await _dio.post(
        getUrl('profile/connect/'),
        data: {"userId": contactUserId},
        
        options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        )
      );
      return response.data['payload'];
    } catch (e) {
      throw Exception('Failed to connect: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getConnections() async {
    try {
      final response = await _dio.get(getUrl('profile/connections/'), 
        options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        ));
      return List<Map<String, dynamic>>.from(response.data['payload']);
    } catch (e) {
      throw Exception('Failed to fetch connections: $e');
    }
  }

  Future<List<SuggestedUser>> getConnectionSuggestions() async {
    try {
      final res = await _dio.get(getUrl('profile/suggestions/'), 
        options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        ));
      final List payload = res.data['payload'];
      return payload.map((e) => SuggestedUser.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load suggestions: $e");
    }
  }
}

final contactRepositoryProvider = Provider((ref) => ContactRepository(Dio()));
