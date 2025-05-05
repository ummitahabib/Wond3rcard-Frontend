class Subscription {
  final String id;
  final String name;
  final BillingCycle billingCycle;
  final String description;
  final int trialPeriod;
  final bool autoRenew;
  final List<String> features;
  final String createdAt;
  final String updatedAt;

  Subscription({
    required this.id,
    required this.name,
    required this.billingCycle,
    required this.description,
    required this.trialPeriod,
    required this.autoRenew,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['_id'],
      name: json['name'],
      billingCycle: BillingCycle.fromJson(json['billingCycle']),
      description: json['description'],
      trialPeriod: json['trialPeriod'],
      autoRenew: json['autoRenew'],
      features: List<String>.from(json['features']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class BillingCycle {
  final Plan monthly;
  final Plan yearly;

  BillingCycle({required this.monthly, required this.yearly});

  factory BillingCycle.fromJson(Map<String, dynamic> json) {
    return BillingCycle(
      monthly: Plan.fromJson(json['monthly']),
      yearly: Plan.fromJson(json['yearly']),
    );
  }
}

class Plan {
  final double price;
  final int durationInDays;

  Plan({required this.price, required this.durationInDays});

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      price: json['price'].toDouble(),
      durationInDays: json['durationInDays'],
    );
  }
}
