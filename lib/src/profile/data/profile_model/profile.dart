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
      print('this is the userprofileresponse error $e');
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
      print('this is the payload error $e');
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

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) {
    try {
      return ActiveSubscription(
        provider: json['provider'],
        subscriptionId: json['subscriptionId'],
        expiryDate: json['expiryDate'],
      );
    } catch (e) {
      print('This is the active subscription error $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'subscriptionId': subscriptionId,
      'expiryDate': expiryDate,
    };
  }
}

class User {
  final ActiveSubscription activeSubscription;
  final String? stripeCustomerId;
  final String? paystackCustomerId;
  final String id;
  final String username;
  final String email;
  final String fcmToken;
  final String userRole;
  final bool mfaEnabled;
  final String userStatus;
  final bool isSoftDeleted;
  final bool isVerified;
  final String userType;
  final String refreshToken;
  final List<String> organizations;
  final String payStackId;
  final String stripeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  User({
    required this.activeSubscription,
    this.stripeCustomerId,
    this.paystackCustomerId,
    required this.id,
    required this.username,
    required this.email,
    required this.fcmToken,
    required this.userRole,
    required this.mfaEnabled,
    required this.userStatus,
    required this.isSoftDeleted,
    required this.isVerified,
    required this.userType,
    required this.refreshToken,
    required this.organizations,
    required this.payStackId,
    required this.stripeId,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        activeSubscription:
            ActiveSubscription.fromJson(json['activeSubscription'] ?? {}),
        stripeCustomerId: json['stripeCustomerId'] as String?,
        paystackCustomerId: json['paystackCustomerId'] as String?,
        id: json['_id'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        fcmToken: json['fcmToken'] as String,
        userRole: json['userRole'] as String,
        mfaEnabled: json['mfaEnabled'] as bool,
        userStatus: json['userStatus'] as String,
        isSoftDeleted: json['isSoftDeleted'] as bool,
        isVerified: json['isVerified'] as bool,
        userType: json['userType'] as String,
        refreshToken: json['refreshToken'] as String,
        organizations: List<String>.from(json['organizations'] ?? []),
        payStackId: json['payStackId'] as String? ?? '',
        stripeId: json['stripeId'] as String? ?? '',
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        version: json['__v'] as int,
      );
    } catch (e) {
      print('this is the user model error $e');
      rethrow;
    }
  }
}

class Profile {
  final String profileUrl;
  final String coverUrl;
  final String id;
  final String uid;
  final String firstname;
  final String othername;
  final String lastname;
  final String mobileNumber;
  final String email;
  final String companyName;
  final String designation;
  final List<String> contacts;
  final List<String> connections;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Profile({
    required this.profileUrl,
    required this.coverUrl,
    required this.id,
    required this.uid,
    required this.firstname,
    required this.othername,
    required this.lastname,
    required this.mobileNumber,
    required this.email,
    required this.companyName,
    required this.designation,
    required this.contacts,
    required this.connections,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    try {
      return Profile(
        profileUrl: json['profileUrl'] as String? ?? '',
        coverUrl: json['coverUrl'] as String? ?? '',
        id: json['_id'] as String,
        uid: json['uid'] as String,
        firstname: json['firstname'] as String,
        othername: json['othername'] as String,
        lastname: json['lastname'] as String,
        mobileNumber: json['mobileNumber'] as String,
        email: json['email'] as String,
        companyName: json['companyName'] as String? ?? '',
        designation: json['designation'] as String? ?? '',
        contacts: List<String>.from(json['contacts'] ?? []),
        connections: List<String>.from(json['connections'] ?? []),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        version: json['__v'] as int,
      );
    } catch (e) {
      print('this is the profile error $e');
      rethrow;
    }
  }
}

class UserProfile {
  final String username;
  final String email;
  final String userRole;
  final String mobileNumber;

  UserProfile({
    required this.username,
    required this.email,
    required this.userRole,
    required this.mobileNumber,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'],
      email: json['email'],
      userRole: json['userRole'],
      mobileNumber: json['mobileNumber'],
    );
  }
}
