class TransactionRecord {
  final String transactionId;
  final String referenceId;
  final String provider;
  final String status;
  final String plan;
  final String billingCycle;
  final String paymentMethod;
  final double amount;
  final String userId;
  final DateTime createdAt;

  TransactionRecord({
    required this.transactionId,
    required this.referenceId,
    required this.provider,
    required this.status,
    required this.plan,
    required this.billingCycle,
    required this.paymentMethod,
    required this.amount,
    required this.userId,
    required this.createdAt,
  });

  factory TransactionRecord.fromJson(Map<String, dynamic> json) {
    return TransactionRecord(
      transactionId: json['transactionId'] ?? '',
      referenceId: json['referenceId'] ?? '',
      provider: json['provider'] ?? '',
      status: json['status'] ?? '',
      plan: json['plan'] ?? '',
      billingCycle: json['billingCycle'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      amount: double.parse(json['amount'].toString()),
      userId: json['userId'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
