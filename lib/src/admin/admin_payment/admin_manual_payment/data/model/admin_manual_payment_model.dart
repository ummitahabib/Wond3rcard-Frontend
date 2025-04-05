class ManualPaymentRequest {
  final String userId;
  final String amount;
  final String plan; // "premium" or "business"
  final String billingCycle; // "monthly" or "yearly"
  final String paymentMethod; // "bank transfer" or "cash"

  ManualPaymentRequest({
    required this.userId,
    required this.amount,
    required this.plan,
    required this.billingCycle,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "amount": amount,
      "plan": plan,
      "billingCycle": billingCycle,
      "paymentMethod": paymentMethod,
    };
  }
}

class ManualPaymentResponse {
  final String transactionId;
  final String message;

  ManualPaymentResponse({
    required this.transactionId,
    required this.message,
  });

  factory ManualPaymentResponse.fromJson(Map<String, dynamic> json) {
    return ManualPaymentResponse(
      transactionId: json['transactionId'],
      message: json['message'],
    );
  }
}
