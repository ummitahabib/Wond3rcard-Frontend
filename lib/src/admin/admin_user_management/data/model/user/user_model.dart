

class GetAllUsersResponse {
  final String status;
  final String message;
  final List<User> payload;

  GetAllUsersResponse({
    required this.status,
    required this.message,
    required this.payload,
  });

  factory GetAllUsersResponse.fromJson(Map<String, dynamic> json) {
    return GetAllUsersResponse(
      status: json['status'],
      message: json['message'],
      payload: (json['payload'] as List)
          .map((userList) => User.fromJson(userList[0]))
          .toList(),
    );
  }

  
}

class User {
  final UserTier userTier;
  final ActiveSubscription activeSubscription;
  final String id;
  final String username;
  final String email;
  final String password;
  final String fcmToken;
  final String userRole;
  final bool is2FAEnabled;
  final bool mfaEnabled;
  final String userStatus;
  final bool isSoftDeleted;
  final bool isVerified;
  final String userType;
  final String refreshToken;
  final List<dynamic> organizations;
  final String? stripeCustomerId;
  final String? paystackCustomerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  User({
    required this.userTier,
    required this.activeSubscription,
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.fcmToken,
    required this.userRole,
    required this.is2FAEnabled,
    required this.mfaEnabled,
    required this.userStatus,
    required this.isSoftDeleted,
    required this.isVerified,
    required this.userType,
    required this.refreshToken,
    required this.organizations,
    required this.stripeCustomerId,
    required this.paystackCustomerId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userTier: UserTier.fromJson(json['userTier']),
      activeSubscription: ActiveSubscription.fromJson(json['activeSubscription']),
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      fcmToken: json['fcmToken'],
      userRole: json['userRole'],
      is2FAEnabled: json['is2FAEnabled'],
      mfaEnabled: json['mfaEnabled'],
      userStatus: json['userStatus'],
      isSoftDeleted: json['isSoftDeleted'],
      isVerified: json['isVerified'],
      userType: json['userType'],
      refreshToken: json['refreshToken'],
      organizations: json['organizations'],
      stripeCustomerId: json['stripeCustomerId'],
      paystackCustomerId: json['paystackCustomerId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

    static List<User> fromPayload(dynamic payload) {
    if (payload is List && payload.isNotEmpty && payload[0] is List) {
      return (payload[0] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();
    }
    return [];
  }
}

class UserTier {
  final String plan;
  final String status;
  final String? transactionId;
  final String? expiresAt;

  UserTier({
    required this.plan,
    required this.status,
    this.transactionId,
    this.expiresAt,
  });

  factory UserTier.fromJson(Map<String, dynamic> json) {
    return UserTier(
      plan: json['plan'],
      status: json['status'],
      transactionId: json['transactionId'],
      expiresAt: json['expiresAt'],
    );
  }

    static List<UserTier> fromPayload(dynamic payload) {
    if (payload is List && payload.isNotEmpty && payload[0] is List) {
      return (payload[0] as List)
          .map((userTierJson) => UserTier.fromJson(userTierJson))
          .toList();
    }
    return [];
  }
}

class ActiveSubscription {
  final String? provider;
  final String? subscriptionId;
  final String? expiryDate;

  ActiveSubscription({
    this.provider,
    this.subscriptionId,
    this.expiryDate,
  });

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) {
    return ActiveSubscription(
      provider: json['provider'],
      subscriptionId: json['subscriptionId'],
      expiryDate: json['expiryDate'],
    );
  }

    static List<ActiveSubscription> fromPayload(dynamic payload) {
    if (payload is List && payload.isNotEmpty && payload[0] is List) {
      return (payload[0] as List)
          .map((activeSubscriptionJson) => ActiveSubscription.fromJson(activeSubscriptionJson))
          .toList();
    }
    return [];
  }
}
