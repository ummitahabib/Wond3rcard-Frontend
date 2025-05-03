class Plan {
  double price;
  int durationInDays;

  Plan({required this.price, required this.durationInDays});

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      price: (json['price'] as num).toDouble(),
      durationInDays: json['durationInDays'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "durationInDays": durationInDays,
    };
  }
}

class BillingCycle {
  Plan monthly;
  Plan yearly;

  BillingCycle({required this.monthly, required this.yearly});

  factory BillingCycle.fromJson(Map<String, dynamic> json) {
    return BillingCycle(
      monthly: Plan.fromJson(json['monthly']),
      yearly: Plan.fromJson(json['yearly']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "monthly": monthly.toJson(),
      "yearly": yearly.toJson(),
    };
  }
}

class SubscriptionTier {
  String id;
  String name;
  BillingCycle billingCycle;
  String description;
  int trialPeriod;
  bool autoRenew;
  List<String> features;

  SubscriptionTier({
    required this.id,
    required this.name,
    required this.billingCycle,
    required this.description,
    required this.trialPeriod,
    required this.autoRenew,
    required this.features,
  });

  factory SubscriptionTier.fromJson(Map<String, dynamic> json) {
    return SubscriptionTier(
      id: json['_id'],
      name: json['name'],
      billingCycle: BillingCycle.fromJson(json['billingCycle']),
      description: json['description'],
      trialPeriod: json['trialPeriod'],
      autoRenew: json['autoRenew'],
      features: List<String>.from(json['features']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "billingCycle": billingCycle.toJson(),
      "description": description,
      "trialPeriod": trialPeriod,
      "autoRenew": autoRenew,
      "features": features,
    };
  }
}
