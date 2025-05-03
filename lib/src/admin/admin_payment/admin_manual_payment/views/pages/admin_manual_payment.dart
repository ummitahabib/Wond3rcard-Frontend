import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/controller/admin_manual_payment_controller.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/model/admin_manual_payment_model.dart';
class ManualPaymentScreen extends ConsumerStatefulWidget {
  const ManualPaymentScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ManualPaymentScreen> createState() => _ManualPaymentScreenState();
}

class _ManualPaymentScreenState extends ConsumerState<ManualPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String selectedPlan = 'premium';
  String selectedBillingCycle = 'monthly';
  String selectedPaymentMethod = 'cash';

  void _submitPayment() {
    if (_formKey.currentState!.validate()) {
      final request = ManualPaymentRequest(
        userId: userIdController.text,
        amount: amountController.text,
        plan: selectedPlan,
        billingCycle: selectedBillingCycle,
        paymentMethod: selectedPaymentMethod,
      );

      ref.read(manualPaymentProvider.notifier).createManualPayment(request).then((_) {
        final paymentState = ref.read(manualPaymentProvider);

        paymentState.when(
          data: (response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Payment Successful: ${response?.transactionId}"),
                backgroundColor: Colors.green,
              ),
            );
          },
          error: (error, _) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: $error"),
                backgroundColor: Colors.red,
              ),
            );
          },
          loading: () {},
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(manualPaymentProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Manual Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: userIdController,
                  decoration: const InputDecoration(labelText: "User ID"),
                  validator: (value) => value!.isEmpty ? "User ID is required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Amount is required" : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedPlan,
                  decoration: const InputDecoration(labelText: "Plan"),
                  onChanged: (value) => setState(() => selectedPlan = value!),
                  items: ["premium", "business"]
                      .map((plan) => DropdownMenuItem(value: plan, child: Text(plan)))
                      .toList(),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedBillingCycle,
                  decoration: const InputDecoration(labelText: "Billing Cycle"),
                  onChanged: (value) => setState(() => selectedBillingCycle = value!),
                  items: ["monthly", "yearly"]
                      .map((cycle) => DropdownMenuItem(value: cycle, child: Text(cycle)))
                      .toList(),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedPaymentMethod,
                  decoration: const InputDecoration(labelText: "Payment Method"),
                  onChanged: (value) => setState(() => selectedPaymentMethod = value!),
                  items: ["cash", "bank transfer"]
                      .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                      .toList(),
                ),
                const SizedBox(height: 32),
                paymentState.maybeWhen(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  orElse: () => ElevatedButton(
                    onPressed: _submitPayment,
                    child: const Text("Submit Payment"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
