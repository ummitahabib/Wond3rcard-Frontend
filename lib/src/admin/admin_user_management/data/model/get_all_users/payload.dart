import 'dart:convert';

import 'package:collection/collection.dart';

import 'active_subscription.dart';
import 'package:flutter/material.dart';

@immutable
class GetAllUsersPayload {
  final ActiveSubscription? activeSubscription;
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? fcmToken;
  final String? userRole;
  final bool? is2FaEnabled;
  final bool? mfaEnabled;
  final String? userStatus;
  final bool? isSoftDeleted;
  final bool? isVerified;
  final String? userType;
  final String? refreshToken;
  final List<dynamic>? organizations;
  final dynamic stripeCustomerId;
  final dynamic paystackCustomerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const GetAllUsersPayload({
    this.activeSubscription,
    this.id,
    this.username,
    this.email,
    this.password,
    this.fcmToken,
    this.userRole,
    this.is2FaEnabled,
    this.mfaEnabled,
    this.userStatus,
    this.isSoftDeleted,
    this.isVerified,
    this.userType,
    this.refreshToken,
    this.organizations,
    this.stripeCustomerId,
    this.paystackCustomerId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Payload(activeSubscription: $activeSubscription, id: $id, username: $username, email: $email, password: $password, fcmToken: $fcmToken, userRole: $userRole, is2FaEnabled: $is2FaEnabled, mfaEnabled: $mfaEnabled, userStatus: $userStatus, isSoftDeleted: $isSoftDeleted, isVerified: $isVerified, userType: $userType, refreshToken: $refreshToken, organizations: $organizations, stripeCustomerId: $stripeCustomerId, paystackCustomerId: $paystackCustomerId, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory GetAllUsersPayload.fromMap(Map<String, dynamic> data) => GetAllUsersPayload(
        activeSubscription: data['activeSubscription'] == null
            ? null
            : ActiveSubscription.fromMap(
                data['activeSubscription'] as Map<String, dynamic>),
        id: data['_id'] as String?,
        username: data['username'] as String?,
        email: data['email'] as String?,
        password: data['password'] as String?,
        fcmToken: data['fcmToken'] as String?,
        userRole: data['userRole'] as String?,
        is2FaEnabled: data['is2FAEnabled'] as bool?,
        mfaEnabled: data['mfaEnabled'] as bool?,
        userStatus: data['userStatus'] as String?,
        isSoftDeleted: data['isSoftDeleted'] as bool?,
        isVerified: data['isVerified'] as bool?,
        userType: data['userType'] as String?,
        refreshToken: data['refreshToken'] as String?,
        organizations: data['organizations'] as List<dynamic>?,
        stripeCustomerId: data['stripeCustomerId'] as dynamic,
        paystackCustomerId: data['paystackCustomerId'] as dynamic,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        v: data['__v'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'activeSubscription': activeSubscription?.toMap(),
        '_id': id,
        'username': username,
        'email': email,
        'password': password,
        'fcmToken': fcmToken,
        'userRole': userRole,
        'is2FAEnabled': is2FaEnabled,
        'mfaEnabled': mfaEnabled,
        'userStatus': userStatus,
        'isSoftDeleted': isSoftDeleted,
        'isVerified': isVerified,
        'userType': userType,
        'refreshToken': refreshToken,
        'organizations': organizations,
        'stripeCustomerId': stripeCustomerId,
        'paystackCustomerId': paystackCustomerId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetAllUsersPayload].
  factory GetAllUsersPayload.fromJson(String data) {
    return GetAllUsersPayload.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetAllUsersPayload] to a JSON string.
  String toJson() => json.encode(toMap());

  GetAllUsersPayload copyWith({
    ActiveSubscription? activeSubscription,
    String? id,
    String? username,
    String? email,
    String? password,
    String? fcmToken,
    String? userRole,
    bool? is2FaEnabled,
    bool? mfaEnabled,
    String? userStatus,
    bool? isSoftDeleted,
    bool? isVerified,
    String? userType,
    String? refreshToken,
    List<dynamic>? organizations,
    dynamic stripeCustomerId,
    dynamic paystackCustomerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return GetAllUsersPayload(
      activeSubscription: activeSubscription ?? this.activeSubscription,
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      fcmToken: fcmToken ?? this.fcmToken,
      userRole: userRole ?? this.userRole,
      is2FaEnabled: is2FaEnabled ?? this.is2FaEnabled,
      mfaEnabled: mfaEnabled ?? this.mfaEnabled,
      userStatus: userStatus ?? this.userStatus,
      isSoftDeleted: isSoftDeleted ?? this.isSoftDeleted,
      isVerified: isVerified ?? this.isVerified,
      userType: userType ?? this.userType,
      refreshToken: refreshToken ?? this.refreshToken,
      organizations: organizations ?? this.organizations,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
      paystackCustomerId: paystackCustomerId ?? this.paystackCustomerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GetAllUsersPayload) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      activeSubscription.hashCode ^
      id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      password.hashCode ^
      fcmToken.hashCode ^
      userRole.hashCode ^
      is2FaEnabled.hashCode ^
      mfaEnabled.hashCode ^
      userStatus.hashCode ^
      isSoftDeleted.hashCode ^
      isVerified.hashCode ^
      userType.hashCode ^
      refreshToken.hashCode ^
      organizations.hashCode ^
      stripeCustomerId.hashCode ^
      paystackCustomerId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
