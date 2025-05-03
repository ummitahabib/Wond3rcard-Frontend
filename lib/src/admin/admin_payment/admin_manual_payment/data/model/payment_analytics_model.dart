class PaymentAnalytics {
  final double totalRevenue;
  final int failedTransactions;
  final int successfulTransactions;
  final int pendingTransactions;
  final List<RevenueByProvider> revenueByProvider;
  final List<RevenueByMonth> revenueByMonth;
  final String failureRate;
  final String mostCommonPaymentMethod;
  final List<UserByTier> usersByTier;

  PaymentAnalytics({
    required this.totalRevenue,
    required this.failedTransactions,
    required this.successfulTransactions,
    required this.pendingTransactions,
    required this.revenueByProvider,
    required this.revenueByMonth,
    required this.failureRate,
    required this.mostCommonPaymentMethod,
    required this.usersByTier,
  });

  factory PaymentAnalytics.fromJson(Map<String, dynamic> json) {
    return PaymentAnalytics(
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
      failedTransactions: json['failedTransactions'] ?? 0,
      successfulTransactions: json['successfulTransactions'] ?? 0,
      pendingTransactions: json['pendingTransactions'] ?? 0,
      revenueByProvider: (json['revenueByProvider'] as List)
          .map((item) => RevenueByProvider.fromJson(item))
          .toList(),
      revenueByMonth: (json['revenueByMonth'] as List)
          .map((item) => RevenueByMonth.fromJson(item))
          .toList(),
      failureRate: json['failureRate'] ?? '0%',
      mostCommonPaymentMethod: json['mostCommonPaymentMethod'] ?? 'N/A',
      usersByTier: (json['usersByTier'] as List)
          .map((item) => UserByTier.fromJson(item))
          .toList(),
    );
  }
}

class RevenueByProvider {
  final String provider;
  final double revenue;

  RevenueByProvider({required this.provider, required this.revenue});

  factory RevenueByProvider.fromJson(Map<String, dynamic> json) {
    return RevenueByProvider(
      provider: json['provider'] ?? '',
      revenue: (json['revenue'] ?? 0).toDouble(),
    );
  }
}

class RevenueByMonth {
  final String month;
  final double revenue;

  RevenueByMonth({required this.month, required this.revenue});

  factory RevenueByMonth.fromJson(Map<String, dynamic> json) {
    return RevenueByMonth(
      month: json['month'] ?? '',
      revenue: (json['revenue'] ?? 0).toDouble(),
    );
  }
}

class UserByTier {
  final String tierName;
  final int userCount;

  UserByTier({required this.tierName, required this.userCount});

  factory UserByTier.fromJson(Map<String, dynamic> json) {
    return UserByTier(
      tierName: json['tierName'] ?? '',
      userCount: json['userCount'] ?? 0,
    );
  }
}
