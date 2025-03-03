import 'dart:convert';

import 'package:collection/collection.dart';

import 'payload.dart';
import 'package:flutter/material.dart';

@immutable
class GetAllUsers {
  final String? status;
  final String? message;
  final List<GetAllUsersPayload>? payload;

  const GetAllUsers({this.status, this.message, this.payload});

  @override
  String toString() {
    return 'GetAllUsers(status: $status, message: $message, payload: $payload)';
  }

  factory GetAllUsers.fromMap(Map<String, dynamic> data) => GetAllUsers(
        status: data['status'] as String?,
        message: data['message'] as String?,
        payload: (data['payload'] as List<dynamic>?)
            ?.map((e) => GetAllUsersPayload.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'payload': payload?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetAllUsers].
  factory GetAllUsers.fromJson(String data) {
    return GetAllUsers.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetAllUsers] to a JSON string.
  String toJson() => json.encode(toMap());

  GetAllUsers copyWith({
    String? status,
    String? message,
    List<GetAllUsersPayload>? payload,
  }) {
    return GetAllUsers(
      status: status ?? this.status,
      message: message ?? this.message,
      payload: payload ?? this.payload,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GetAllUsers) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ payload.hashCode;
}
