import 'dart:convert';

import 'package:collection/collection.dart';

@immutable
class ActiveSubscription {
  final dynamic provider;
  final dynamic subscriptionId;
  final dynamic expiryDate;

  const ActiveSubscription({
    this.provider,
    this.subscriptionId,
    this.expiryDate,
  });

  @override
  String toString() {
    return 'ActiveSubscription(provider: $provider, subscriptionId: $subscriptionId, expiryDate: $expiryDate)';
  }

  factory ActiveSubscription.fromMap(Map<String, dynamic> data) {
    return ActiveSubscription(
      provider: data['provider'] as dynamic,
      subscriptionId: data['subscriptionId'] as dynamic,
      expiryDate: data['expiryDate'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'provider': provider,
        'subscriptionId': subscriptionId,
        'expiryDate': expiryDate,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ActiveSubscription].
  factory ActiveSubscription.fromJson(String data) {
    return ActiveSubscription.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ActiveSubscription] to a JSON string.
  String toJson() => json.encode(toMap());

  ActiveSubscription copyWith({
    dynamic provider,
    dynamic subscriptionId,
    dynamic expiryDate,
  }) {
    return ActiveSubscription(
      provider: provider ?? this.provider,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ActiveSubscription) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      provider.hashCode ^ subscriptionId.hashCode ^ expiryDate.hashCode;
}
