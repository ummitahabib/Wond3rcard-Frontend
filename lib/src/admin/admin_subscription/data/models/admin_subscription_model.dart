class Subscription {
  final String name;
  final BillingCycle billingCycle;
  final String description;
  final int trialPeriod;
  final bool autoRenew;
  final List<String> features;
  final String? id;

  Subscription({
    required this.name,
    required this.billingCycle,
    required this.description,
    required this.trialPeriod,
    required this.autoRenew,
    required this.features,
    this.id,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      name: json['name'],
      billingCycle: BillingCycle.fromJson(json['billingCycle']),
      description: json['description'],
      trialPeriod: json['trialPeriod'],
      autoRenew: json['autoRenew'],
      features: List<String>.from(json['features']),
      id: json['_id'],
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

  Map<String, dynamic> toJson() {
    return {
      "monthly": monthly.toJson(),
      "yearly": yearly.toJson(),
    };
  }
}

class Plan {
  final int price;
  final int durationInDays;

  Plan({required this.price, required this.durationInDays});

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      price: json['price'],
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
