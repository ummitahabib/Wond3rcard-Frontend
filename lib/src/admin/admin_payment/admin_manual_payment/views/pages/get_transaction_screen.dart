import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/controller/admin_manual_payment_controller.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  String selectedProvider = 'manual'; // Default provider

  @override
  void initState() {
    super.initState();
    // Load transactions for default provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transactionsProvider.notifier).getTransactions(selectedProvider);
    });
  }

  void _fetchTransactions(String provider) {
    setState(() {
      selectedProvider = provider;
    });
    ref.read(transactionsProvider.notifier).getTransactions(provider);
  }

  @override
  Widget build(BuildContext context) {
    final transactionsState = ref.watch(transactionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Transactions by Provider")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Provider Dropdown
            DropdownButtonFormField<String>(
              value: selectedProvider,
              decoration: const InputDecoration(labelText: "Select Provider"),
              onChanged: (value) {
                if (value != null) _fetchTransactions(value);
              },
              items: ["manual", "stripe", "paypal", "bank"]
                  .map((provider) => DropdownMenuItem(
                        value: provider,
                        child: Text(provider.toUpperCase()),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Transactions List
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
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("User ID: ${transaction.userId}"),
                              Text("Amount: \$${transaction.amount.toStringAsFixed(2)}"),
                              Text("Provider: ${transaction.provider}"),
                              Text("Date: ${transaction.createdAt.toLocal()}"),
                            ],
                          ),
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
