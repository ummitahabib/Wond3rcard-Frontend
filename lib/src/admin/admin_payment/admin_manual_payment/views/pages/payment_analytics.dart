import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/controller/admin_manual_payment_controller.dart';

class PaymentAnalyticsScreen extends ConsumerWidget {
  const PaymentAnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsState = ref.watch(paymentAnalyticsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Payment Analytics')),
      body: analyticsState.when(
        data: (analytics) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildStatCard("Total Revenue", "\$${analytics.totalRevenue.toStringAsFixed(2)}"),
              _buildStatCard("Successful Transactions", analytics.successfulTransactions.toString()),
              _buildStatCard("Pending Transactions", analytics.pendingTransactions.toString()),
              _buildStatCard("Failed Transactions", analytics.failedTransactions.toString()),
              _buildStatCard("Failure Rate", analytics.failureRate),
              _buildStatCard("Most Common Payment Method", analytics.mostCommonPaymentMethod),
              const SizedBox(height: 20),
              const Text("Revenue by Provider", style: TextStyle(fontWeight: FontWeight.bold)),
              ...analytics.revenueByProvider.map((provider) => ListTile(
                    title: Text(provider.provider),
                    trailing: Text("\$${provider.revenue.toStringAsFixed(2)}"),
                  )),
              const SizedBox(height: 20),
              const Text("Revenue by Month", style: TextStyle(fontWeight: FontWeight.bold)),
              ...analytics.revenueByMonth.map((month) => ListTile(
                    title: Text(month.month),
                    trailing: Text("\$${month.revenue.toStringAsFixed(2)}"),
                  )),
              const SizedBox(height: 20),
              const Text("Users by Tier", style: TextStyle(fontWeight: FontWeight.bold)),
              ...analytics.usersByTier.map((tier) => ListTile(
                    title: Text(tier.tierName),
                    trailing: Text("${tier.userCount} Users"),
                  )),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
