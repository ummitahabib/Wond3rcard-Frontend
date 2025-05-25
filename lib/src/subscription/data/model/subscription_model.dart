class SubscriptionRequest {
  final String userId;
  final String plan; // Options: 'basic', 'business', 'premium'
  final String billingCycle; // Options: 'monthly', 'yearly'

  SubscriptionRequest({
    required this.userId,
    required this.plan,
    required this.billingCycle,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'plan': plan,
        'billingCycle': billingCycle,
      };
}

class SubscriptionResponse {
  final String checkoutUrl;
  final String reference;

  SubscriptionResponse({
    required this.checkoutUrl,
    required this.reference,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    return SubscriptionResponse(
      checkoutUrl: payload['checkoutUrl'],
      reference: payload['reference'],
    );
  }
}
