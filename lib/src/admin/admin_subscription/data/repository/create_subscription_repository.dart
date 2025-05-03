import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_get_subscription_model.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_subscription_model.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/update_subscription_model.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';

class CreateSubscriptionRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: Endpoints.devBaseUrl,));

       final String? token =
      StorageUtil.getString(key: SessionString.accessTokenString);
  Future<Subscription> createSubscription(Subscription subscription) async {
    

    try {
      Response response = await _dio.post(
        Endpoints.createSusbcription,
        data: subscription.toJson(),
        
        options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        )
        
      );

      if (response.statusCode == 201) {
        return Subscription.fromJson(response.data['payload']);
      } else {
        print("Failed to create subscription");
        throw Exception("Failed to create subscription");
      }
    } catch (e) {
      print("Error to create subscription: $e");
      throw Exception("Error: $e");
    }
  }



  Future<List<GetSubscriptionTier>> getSubscriptionTiers() async {
    try {
      print('this is the token from subscription $token');
      Response response = await _dio.get("admin/subscription-tiers",    
      options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        )
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['payload'];
        return data.map((json) => GetSubscriptionTier.fromJson(json)).toList();
      } else {
        print("Failed to fetch subscriptions");
        throw Exception("Failed to fetch subscriptions");
      }
    } catch (e) {
      print("This is the subscription Error: $e");
      throw Exception("This is the subscription Error: $e");
    }
  }





    Future<SubscriptionTier> updateSubscriptionTier(String id, SubscriptionTier updatedTier) async {
    try {
      Response response = await _dio.patch(
        "admin/subscription-tiers/$id",
        data: updatedTier.toJson(),
         options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        )
      );

      if (response.statusCode == 200) {
        return SubscriptionTier.fromJson(response.data['payload']);
      } else {
        throw Exception("Failed to update subscription tier");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }


  Future<void> deleteSubscriptionTier(String id, String newTierId) async {
    try {
      Response response = await _dio.delete(
        "admin/subscription-tiers/$id",
        data: {"newTierId": newTierId},
            options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        )
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to delete subscription");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }



    Future<Subscription> getSubscriptionById(String id) async {
    try {
      Response response = await _dio.get("admin/subscription-tiers/$id", 
          options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        )
      );
      if (response.statusCode == 200) {
        return Subscription.fromJson(response.data['payload']);
      } else {
        throw Exception("Failed to fetch subscription");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}













