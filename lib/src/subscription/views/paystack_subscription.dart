import 'package:flutter/material.dart';
import 'package:flutter_paystack_payment/flutter_paystack_payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wond3rcard/src/subscription/data/controller/subscription_controller.dart';
import 'package:wond3rcard/src/subscription/data/model/subscription_model.dart';
import 'package:wond3rcard/src/utils/util.dart';

class SubscriptionPage extends ConsumerStatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends ConsumerState<SubscriptionPage> {
  final PaystackPayment _paystackPlugin = PaystackPayment();

  @override
  void initState() {
    super.initState();
    _initializePaystack();
  }

  void _initializePaystack() {
    _paystackPlugin.initialize(publicKey: kPaystackKey);
  }

  void _startPayment(String checkoutUrl) {
    // For web-based checkout, you can use a WebView or url_launcher
    // For this example, we'll use url_launcher
    launchUrl(Uri.parse(checkoutUrl));
  }

  void _subscribe(String plan) async {
    final request = SubscriptionRequest(
      userId: '68151c1202638edab80150f8',
      plan: plan,
      billingCycle: 'monthly',
    );

    await ref
        .read(subscriptionControllerProvider.notifier)
        .initiateSubscription(request);
    final state = ref.read(subscriptionControllerProvider);

    state.when(
      data: (response) {
        _startPayment(response.checkoutUrl);
      },
      loading: () {
        // Show loading indicator
      },
      error: (error, stack) {
        // Handle error
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final plans = ['basic', 'business', 'premium'];

    return Scaffold(
      appBar: AppBar(title: const Text('Choose a Plan')),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return ListTile(
            title: Text(plan.toUpperCase()),
            trailing: ElevatedButton(
              onPressed: () => _subscribe(plan),
              child: const Text('Subscribe'),
            ),
          );
        },
      ),
    );
  }
}
