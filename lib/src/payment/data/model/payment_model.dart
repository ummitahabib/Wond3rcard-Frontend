class PaymentRequestModel {
  final String userId;
  final String plan;
  final String billingCycle;

  PaymentRequestModel({
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

class PaymentResponseModel {
  final String checkoutUrl;
  final String reference;

  PaymentResponseModel({required this.checkoutUrl, required this.reference});

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      checkoutUrl: json['checkoutUrl'],
      reference: json['reference'],
    );
  }
}
