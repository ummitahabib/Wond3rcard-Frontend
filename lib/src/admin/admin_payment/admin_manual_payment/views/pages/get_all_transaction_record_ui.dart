import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/controller/admin_manual_payment_controller.dart';

class TransactionRecordScreen extends ConsumerStatefulWidget {
  const TransactionRecordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TransactionRecordScreen> createState() => _TransactionRecordScreenState();
}

class _TransactionRecordScreenState extends ConsumerState<TransactionRecordScreen> {
  String? selectedProvider;
  String? selectedStatus;
  String? selectedPlan;
  String? selectedBillingCycle;
  String? selectedPaymentMethod;
  final TextEditingController transactionIdController = TextEditingController();
  final TextEditingController referenceIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() {
    ref.read(transactionsRecordProvider.notifier).getTransactions(
      provider: selectedProvider,
      status: selectedStatus,
      plan: selectedPlan,
      billingCycle: selectedBillingCycle,
      paymentMethod: selectedPaymentMethod,
      transactionId: transactionIdController.text,
      referenceId: referenceIdController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionsState = ref.watch(transactionsRecordProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Transaction Records")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filters
            DropdownButtonFormField<String>(
              value: selectedProvider,
              decoration: const InputDecoration(labelText: "Provider"),
              items: ["manual", "stripe", "paypal", "bank"]
                  .map((provider) => DropdownMenuItem(value: provider, child: Text(provider.toUpperCase())))
                  .toList(),
              onChanged: (value) => setState(() => selectedProvider = value),
            ),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: const InputDecoration(labelText: "Status"),
              items: ["success", "pending", "failed"]
                  .map((status) => DropdownMenuItem(value: status, child: Text(status.toUpperCase())))
                  .toList(),
              onChanged: (value) => setState(() => selectedStatus = value),
            ),
            TextField(
              controller: transactionIdController,
              decoration: const InputDecoration(labelText: "Transaction ID"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchTransactions,
              child: const Text("Search Transactions"),
            ),
            const SizedBox(height: 20),

            // Transaction List
            Expanded(
              child: transactionsState.when(
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return const Center(child: Text("No transactions found."));
                  }
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text("Transaction ID: ${transaction.transactionId}"),
                          subtitle: Text("Amount: \$${transaction.amount.toStringAsFixed(2)}"),
                          trailing: Text(transaction.status.toUpperCase(), style: TextStyle(color: Colors.green)),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: Text("Error: $error", style: const TextStyle(color: Colors.red)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
