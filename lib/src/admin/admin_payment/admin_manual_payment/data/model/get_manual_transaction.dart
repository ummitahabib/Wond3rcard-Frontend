class Transaction {
  final String transactionId;
  final String provider;
  final double amount;
  final String userId;
  final DateTime createdAt;

  Transaction({
    required this.transactionId,
    required this.provider,
    required this.amount,
    required this.userId,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transactionId'],
      provider: json['provider'],
      amount: double.parse(json['amount'].toString()),
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
