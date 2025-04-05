import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/controller/create_subscription_controller.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/update_subscription_model.dart';

class EditSubscriptionScreen extends ConsumerStatefulWidget {
  final SubscriptionTier subscription;

  const EditSubscriptionScreen({Key? key, required this.subscription}) : super(key: key);

  @override
  ConsumerState<EditSubscriptionScreen> createState() => _EditSubscriptionScreenState();
}

class _EditSubscriptionScreenState extends ConsumerState<EditSubscriptionScreen> {
  late TextEditingController nameController;
  late TextEditingController monthlyPriceController;
  late TextEditingController yearlyPriceController;
  late TextEditingController descriptionController;
  late TextEditingController trialPeriodController;
  bool autoRenew = true;
  List<String> features = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.subscription.name);
    monthlyPriceController = TextEditingController(text: widget.subscription.billingCycle.monthly.price.toString());
    yearlyPriceController = TextEditingController(text: widget.subscription.billingCycle.yearly.price.toString());
    descriptionController = TextEditingController(text: widget.subscription.description);
    trialPeriodController = TextEditingController(text: widget.subscription.trialPeriod.toString());
    autoRenew = widget.subscription.autoRenew;
    features = List<String>.from(widget.subscription.features);
  }

  void _updateSubscription() {
    final updatedSubscription = SubscriptionTier(
      id: widget.subscription.id,
      name: nameController.text,
      billingCycle: BillingCycle(
        monthly: Plan(price: double.parse(monthlyPriceController.text), durationInDays: 30),
        yearly: Plan(price: double.parse(yearlyPriceController.text), durationInDays: 365),
      ),
      description: descriptionController.text,
      trialPeriod: int.parse(trialPeriodController.text),
      autoRenew: autoRenew,
      features: features,
    );

    ref.read(editSubscriptionProvider.notifier).updateSubscription(widget.subscription.id, updatedSubscription);
  }

  @override
  Widget build(BuildContext context) {
    final editState = ref.watch(editSubscriptionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Subscription")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Subscription Name")),
            TextField(controller: monthlyPriceController, decoration: const InputDecoration(labelText: "Monthly Price"), keyboardType: TextInputType.number),
            TextField(controller: yearlyPriceController, decoration: const InputDecoration(labelText: "Yearly Price"), keyboardType: TextInputType.number),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Description")),
            TextField(controller: trialPeriodController, decoration: const InputDecoration(labelText: "Trial Period"), keyboardType: TextInputType.number),
            SwitchListTile(
              title: const Text("Auto-Renew"),
              value: autoRenew,
              onChanged: (value) => setState(() => autoRenew = value),
            ),
            const SizedBox(height: 10),
            editState.when(
              data: (data) => data != null
                  ? Text("Updated: ${data.name}", style: const TextStyle(color: Colors.green))
                  : Container(),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text("Error: $error", style: const TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateSubscription,
              child: const Text("Update Subscription"),
            ),
          ],
        ),
      ),
    );
  }
}
