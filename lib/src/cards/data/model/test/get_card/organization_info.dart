import 'dart:convert';

import 'package:collection/collection.dart';

class OrganizationInfo {
  String? organizationName;

  OrganizationInfo({this.organizationName});

  @override
  String toString() {
    return 'OrganizationInfo(organizationName: $organizationName)';
  }

  factory OrganizationInfo.fromMap(Map<String, dynamic> data) {
    return OrganizationInfo(
      organizationName: data['organizationName'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'organizationName': organizationName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrganizationInfo].
  factory OrganizationInfo.fromJson(String data) {
    return OrganizationInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrganizationInfo] to a JSON string.
  String toJson() => json.encode(toMap());

  OrganizationInfo copyWith({
    String? organizationName,
  }) {
    return OrganizationInfo(
      organizationName: organizationName ?? this.organizationName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrganizationInfo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => organizationName.hashCode;
}
