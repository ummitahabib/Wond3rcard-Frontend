import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'organization_info.g.dart';

@HiveType(typeId: 0)
class OrganizationInfo extends HiveObject {
  @HiveField(0)
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

  factory OrganizationInfo.fromJson(String data) {
    return OrganizationInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

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
