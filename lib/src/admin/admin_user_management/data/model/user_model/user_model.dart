import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class ApiResponse with _$ApiResponse {
  const factory ApiResponse({
    required String status,
    required String message,
    required Payload payload,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
}

@freezed
class Payload with _$Payload {
  const factory Payload({
    required List<User> users,
    required int total,
    required int page,
    required int limit,
  }) = _Payload;

  factory Payload.fromJson(Map<String, dynamic> json) => _$PayloadFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    required UserTier userTier,
    required ActiveSubscription activeSubscription,
    required String id,
    required String username,
    required String email,
    required String password,
    required String fcmToken,
    required String userRole,
    required bool is2FAEnabled,
    required bool mfaEnabled,
    required String userStatus,
    required bool isSoftDeleted,
    required bool isVerified,
    required String userType,
    required String refreshToken,
    required List<dynamic> organizations,
    String? stripeCustomerId,
    String? paystackCustomerId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int v,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserTier with _$UserTier {
  const factory UserTier({
    required String plan,
    required String status,
    String? transactionId,
    String? expiresAt,
  }) = _UserTier;

  factory UserTier.fromJson(Map<String, dynamic> json) => _$UserTierFromJson(json);
}

@freezed
class ActiveSubscription with _$ActiveSubscription {
  const factory ActiveSubscription({
    String? provider,
    String? subscriptionId,
    String? expiryDate,
  }) = _ActiveSubscription;

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) => _$ActiveSubscriptionFromJson(json);
}
