// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl _$$ApiResponseImplFromJson(Map<String, dynamic> json) =>
    _$ApiResponseImpl(
      status: json['status'] as String,
      message: json['message'] as String,
      payload: Payload.fromJson(json['payload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ApiResponseImplToJson(_$ApiResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'payload': instance.payload,
    };

_$PayloadImpl _$$PayloadImplFromJson(Map<String, dynamic> json) =>
    _$PayloadImpl(
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$$PayloadImplToJson(_$PayloadImpl instance) =>
    <String, dynamic>{
      'users': instance.users,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      userTier: UserTier.fromJson(json['userTier'] as Map<String, dynamic>),
      activeSubscription: ActiveSubscription.fromJson(
          json['activeSubscription'] as Map<String, dynamic>),
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      fcmToken: json['fcmToken'] as String,
      userRole: json['userRole'] as String,
      is2FAEnabled: json['is2FAEnabled'] as bool,
      mfaEnabled: json['mfaEnabled'] as bool,
      userStatus: json['userStatus'] as String,
      isSoftDeleted: json['isSoftDeleted'] as bool,
      isVerified: json['isVerified'] as bool,
      userType: json['userType'] as String,
      refreshToken: json['refreshToken'] as String,
      organizations: json['organizations'] as List<dynamic>,
      stripeCustomerId: json['stripeCustomerId'] as String?,
      paystackCustomerId: json['paystackCustomerId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['v'] as num).toInt(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'userTier': instance.userTier,
      'activeSubscription': instance.activeSubscription,
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'fcmToken': instance.fcmToken,
      'userRole': instance.userRole,
      'is2FAEnabled': instance.is2FAEnabled,
      'mfaEnabled': instance.mfaEnabled,
      'userStatus': instance.userStatus,
      'isSoftDeleted': instance.isSoftDeleted,
      'isVerified': instance.isVerified,
      'userType': instance.userType,
      'refreshToken': instance.refreshToken,
      'organizations': instance.organizations,
      'stripeCustomerId': instance.stripeCustomerId,
      'paystackCustomerId': instance.paystackCustomerId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'v': instance.v,
    };

_$UserTierImpl _$$UserTierImplFromJson(Map<String, dynamic> json) =>
    _$UserTierImpl(
      plan: json['plan'] as String,
      status: json['status'] as String,
      transactionId: json['transactionId'] as String?,
      expiresAt: json['expiresAt'] as String?,
    );

Map<String, dynamic> _$$UserTierImplToJson(_$UserTierImpl instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'status': instance.status,
      'transactionId': instance.transactionId,
      'expiresAt': instance.expiresAt,
    };

_$ActiveSubscriptionImpl _$$ActiveSubscriptionImplFromJson(
        Map<String, dynamic> json) =>
    _$ActiveSubscriptionImpl(
      provider: json['provider'] as String?,
      subscriptionId: json['subscriptionId'] as String?,
      expiryDate: json['expiryDate'] as String?,
    );

Map<String, dynamic> _$$ActiveSubscriptionImplToJson(
        _$ActiveSubscriptionImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'subscriptionId': instance.subscriptionId,
      'expiryDate': instance.expiryDate,
    };
