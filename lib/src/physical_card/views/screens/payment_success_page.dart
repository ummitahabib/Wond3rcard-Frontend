import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  final String? trxRef;
  final String? reference;

  const PaymentSuccessPage({
    super.key,
    this.trxRef,
    this.reference,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Successful'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              const Text(
                'Thank you! Your payment was successful.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (trxRef != null)
                Text('Transaction Ref: $trxRef', textAlign: TextAlign.center),
              if (reference != null)
                Text('Reference: $reference', textAlign: TextAlign.center),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
