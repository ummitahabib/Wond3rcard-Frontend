
class GetSubscriptionTier {
  final String id;
  final String name;

  GetSubscriptionTier({
    required this.id,
    required this.name,
  });
  factory GetSubscriptionTier.fromJson(Map<String, dynamic> json) {
    return GetSubscriptionTier(
      id: json['id'] ?? "Unknown ID",
      name: json['name'] ?? "Unnamed Tier",
    );
  }

  @override
  String toString() => 'GetSubscriptionTier(id: $id, name: $name)';
}
