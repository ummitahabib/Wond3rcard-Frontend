import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/controller/create_subscription_controller.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_subscription_model.dart';

class CreateSubscriptionScreen extends ConsumerStatefulWidget {
  const CreateSubscriptionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateSubscriptionScreen> createState() =>
      _CreateSubscriptionScreenState();
}

class _CreateSubscriptionScreenState
    extends ConsumerState<CreateSubscriptionScreen> {
  final TextEditingController monthlyPriceController = TextEditingController();
  final TextEditingController monthlyDurationController =
      TextEditingController();
  final TextEditingController yearlyPriceController = TextEditingController();
  final TextEditingController yearlyDurationController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController trialPeriodController = TextEditingController();
  final TextEditingController featuresController = TextEditingController();

  String selectedPlan = "Basic";
  bool autoRenew = true;

  void _createSubscription() {
    final subscription = Subscription(
      name: selectedPlan,
      billingCycle: BillingCycle(
        monthly: Plan(
          price: int.tryParse(monthlyPriceController.text) ?? 0,
          durationInDays: int.tryParse(monthlyDurationController.text) ?? 30,
        ),
        yearly: Plan(
          price: int.tryParse(yearlyPriceController.text) ?? 0,
          durationInDays: int.tryParse(yearlyDurationController.text) ?? 365,
        ),
      ),
      description: descriptionController.text,
      trialPeriod: int.tryParse(trialPeriodController.text) ?? 14,
      autoRenew: autoRenew,
      features: featuresController.text.split(','),
    );

    ref
        .read(createSubscriptionProvider.notifier)
        .createSubscription(subscription);
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionState = ref.watch(createSubscriptionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Subscription")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedPlan,
                items: ["Business", "Basic", "Premium"]
                    .map((plan) =>
                        DropdownMenuItem(value: plan, child: Text(plan)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPlan = value!;
                  });
                },
                decoration: const InputDecoration(labelText: "Plan Name"),
              ),
              TextField(
                controller: monthlyPriceController,
                decoration: const InputDecoration(labelText: "Monthly Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: monthlyDurationController,
                decoration:
                    const InputDecoration(labelText: "Monthly Duration (Days)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: yearlyPriceController,
                decoration: const InputDecoration(labelText: "Yearly Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: yearlyDurationController,
                decoration:
                    const InputDecoration(labelText: "Yearly Duration (Days)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: trialPeriodController,
                decoration:
                    const InputDecoration(labelText: "Trial Period (Days)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: featuresController,
                decoration: const InputDecoration(
                  labelText: "Features (Comma Separated)",
                  hintText: "e.g. Limited Access, Priority Support",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Auto-Renew"),
                  Switch(
                    value: autoRenew,
                    onChanged: (value) {
                      setState(() {
                        autoRenew = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              subscriptionState.when(
                data: (data) => data != null
                    ? Text("Subscription Created: ${data.name}",
                        style: const TextStyle(color: Colors.green))
                    : Container(),
                loading: () => const CircularProgressIndicator(),
                error: (error, _) => Text("Error: $error",
                    style: const TextStyle(color: Colors.red)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createSubscription,
                child: const Text("Create Subscription"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
