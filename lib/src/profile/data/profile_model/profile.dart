class UserProfileResponse {
  final int statusCode;
  final String status;
  final Payload payload;

  UserProfileResponse({
    required this.statusCode,
    required this.status,
    required this.payload,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    try {
      return UserProfileResponse(
        statusCode: json['statusCode'] as int,
        status: json['status'] as String,
        payload: Payload.fromJson(json['payload'] as Map<String, dynamic>),
      );
    } catch (e) {
      print('UserProfileResponse error: $e');
      rethrow;
    }
  }
}

class Payload {
  final User user;
  final Profile profile;

  Payload({
    required this.user,
    required this.profile,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    try {
      return Payload(
        user: User.fromJson(json['user'] as Map<String, dynamic>),
        profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
      );
    } catch (e) {
      print('Payload error: $e');
      rethrow;
    }
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

  factory ActiveSubscription.fromJson(Map<String, dynamic>? json) {
    try {
      return ActiveSubscription(
        provider: json?['provider'],
        subscriptionId: json?['subscriptionId'],
        expiryDate: json?['expiryDate'],
      );
    } catch (e) {
      print('ActiveSubscription error: $e');
      rethrow;
    }
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

  factory UserTier.fromJson(Map<String, dynamic>? json) {
    try {
      return UserTier(
        plan: json?['plan'] ?? 'free',
        status: json?['status'] ?? 'inactive',
        transactionId: json?['transactionId'],
        expiresAt: json?['expiresAt'],
      );
    } catch (e) {
      print('UserTier error: $e');
      rethrow;
    }
  }
}

class User {
  final String id;
  final String username;
  final String email;
  final String fcmToken;
  final String userRole;
  final bool mfaEnabled;
  final String userStatus;
  final bool isSoftDeleted;
  final bool isVerified;
  final String refreshToken;
  final List<String> organizations;
  final String? stripeCustomerId;
  final String? paystackCustomerId;
  final String? zoomAccessToken;
  final String? googleMeetAccessToken;
  final String? microsoftTeamsAccessToken;
  final String? tokenExpiry;
  final ActiveSubscription activeSubscription;
  final UserTier userTier;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.fcmToken,
    required this.userRole,
    required this.mfaEnabled,
    required this.userStatus,
    required this.isSoftDeleted,
    required this.isVerified,
    required this.refreshToken,
    required this.organizations,
    this.stripeCustomerId,
    this.paystackCustomerId,
    this.zoomAccessToken,
    this.googleMeetAccessToken,
    this.microsoftTeamsAccessToken,
    this.tokenExpiry,
    required this.activeSubscription,
    required this.userTier,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['_id'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        fcmToken: json['fcmToken'] as String,
        userRole: json['userRole'] as String,
        mfaEnabled: json['mfaEnabled'] as bool,
        userStatus: json['userStatus'] as String,
        isSoftDeleted: json['isSoftDeleted'] as bool,
        isVerified: json['isVerified'] as bool,
        refreshToken: json['refreshToken'] as String,
        organizations: List<String>.from(json['organizations'] ?? []),
        stripeCustomerId: json['stripeCustomerId'],
        paystackCustomerId: json['paystackCustomerId'],
        zoomAccessToken: json['zoomAccessToken'],
        googleMeetAccessToken: json['googleMeetAccessToken'],
        microsoftTeamsAccessToken: json['microsoftTeamsAccessToken'],
        tokenExpiry: json['tokenExpiry'],
        activeSubscription:
            ActiveSubscription.fromJson(json['activeSubscription']),
        userTier: UserTier.fromJson(json['userTier']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        version: json['__v'] as int,
      );
    } catch (e) {
      print('User error: $e');
      rethrow;
    }
  }
}

class Profile {
  final String id;
  final String uid;
  final String firstname;
  final String othername;
  final String lastname;
  final String mobileNumber;
  final String email;
  final String companyName;
  final String designation;
  final String profileUrl;
  final String coverUrl;
  final List<String> contacts;
  final List<String> connections;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Profile({
    required this.id,
    required this.uid,
    required this.firstname,
    required this.othername,
    required this.lastname,
    required this.mobileNumber,
    required this.email,
    required this.companyName,
    required this.designation,
    required this.profileUrl,
    required this.coverUrl,
    required this.contacts,
    required this.connections,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    try {
      return Profile(
        id: json['_id'] as String,
        uid: json['uid'] as String,
        firstname: json['firstname'] as String,
        othername: json['othername'] as String? ?? '',
        lastname: json['lastname'] as String,
        mobileNumber: json['mobileNumber'] as String,
        email: json['email'] as String,
        companyName: json['companyName'] as String? ?? '',
        designation: json['designation'] as String? ?? '',
        profileUrl: json['profileUrl'] as String? ?? '',
        coverUrl: json['coverUrl'] as String? ?? '',
        contacts: List<String>.from(json['contacts'] ?? []),
        connections: List<String>.from(json['connections'] ?? []),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        version: json['__v'] as int,
      );
    } catch (e) {
      print('Profile error: $e');
      rethrow;
    }
  }
}
