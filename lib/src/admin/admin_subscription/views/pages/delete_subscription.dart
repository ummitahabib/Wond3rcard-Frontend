import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/controller/create_subscription_controller.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_get_subscription_model.dart';

class SubscriptionListScreen extends ConsumerWidget {
  const SubscriptionListScreen({Key? key}) : super(key: key);

  void _deleteSubscription(BuildContext context, WidgetRef ref, String id, List<GetSubscriptionTier> tiers) {
    if (tiers.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cannot delete the only subscription tier!"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    // Select the first available tier for migration
    String newTierId = tiers.firstWhere((tier) => tier.id != id).id;

    ref.read(deleteSubscriptionProvider.notifier).deleteSubscription(id, newTierId).then((_) {
      ref.refresh(getSubscriptionTiersProvider); // Refresh the list after deletion
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Subscription deleted successfully!"),
        backgroundColor: Colors.green,
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${error.toString()}"),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionState = ref.watch(getSubscriptionTiersProvider);
    final deleteState = ref.watch(deleteSubscriptionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Subscription Tiers")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: subscriptionState.when(
          data: (tiers) => ListView.builder(
            itemCount: tiers.length,
            itemBuilder: (context, index) {
              final tier = tiers[index];
              return Card(
                child: ListTile(
                  title: Text(tier.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text("ID: ${tier.id}"),
                  trailing: deleteState.isLoading
                      ? const CircularProgressIndicator()
                      : IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteSubscription(context, ref, tier.id, tiers),
                        ),
                ),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text("Error: $error")),
        ),
      ),
    );
  }
}
