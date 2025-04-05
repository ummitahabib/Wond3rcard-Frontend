import 'package:dio/dio.dart';

// Subscription Tier Model
class GetSubscriptionTier {
  final String id;
  final String name;

  GetSubscriptionTier({
    required this.id,
    required this.name,
  });

  // Factory method to create an instance from JSON
  factory GetSubscriptionTier.fromJson(Map<String, dynamic> json) {
    return GetSubscriptionTier(
      id: json['id'] ?? "Unknown ID",         // Ensure non-null id
      name: json['name'] ?? "Unnamed Tier",   // Ensure non-null name
    );
  }

  @override
  String toString() => 'GetSubscriptionTier(id: $id, name: $name)';
}