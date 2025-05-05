import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/controller/create_subscription_controller.dart';

class SubscriptionDetailsScreen extends ConsumerWidget {
  final String subscriptionId;

  const SubscriptionDetailsScreen({Key? key, required this.subscriptionId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionState = ref.watch(subscriptionByIdProvider(subscriptionId));

    return Scaffold(
      appBar: AppBar(title: const Text("Subscription Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: subscriptionState.when(
          data: (subscription) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${subscription.name}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Description: ${subscription.description}"),
              const SizedBox(height: 10),
              Text("Trial Period: ${subscription.trialPeriod} days"),
              const SizedBox(height: 10),
              Text("Auto Renew: ${subscription.autoRenew ? "Yes" : "No"}"),
              const SizedBox(height: 10),
              Text("Monthly Price: \$${subscription.billingCycle.monthly.price} for ${subscription.billingCycle.monthly.durationInDays} days"),
              Text("Yearly Price: \$${subscription.billingCycle.yearly.price} for ${subscription.billingCycle.yearly.durationInDays} days"),
              const SizedBox(height: 10),
              const Text("Features:", style: TextStyle(fontWeight: FontWeight.bold)),
              for (var feature in subscription.features) Text("- $feature"),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text("Error: $error")),
        ),
      ),
    );
  }
}
