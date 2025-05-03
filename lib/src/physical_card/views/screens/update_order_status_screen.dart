import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/order_physical_card_controller.dart';

class UpdateOrderStatusPage extends ConsumerStatefulWidget {
  final String orderId;

  const UpdateOrderStatusPage({super.key, required this.orderId});

  @override
  ConsumerState<UpdateOrderStatusPage> createState() => _UpdateOrderStatusPageState();
}

class _UpdateOrderStatusPageState extends ConsumerState<UpdateOrderStatusPage> {
  String _selectedStatus = 'unpaid';

  final List<String> _statusOptions = ['paid', 'unpaid'];

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(orderStatusControllerProvider(widget.orderId));

    return Scaffold(
      appBar: AppBar(title: const Text("Update Order Status")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Status:", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: _statusOptions
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedStatus = val);
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(orderStatusControllerProvider(widget.orderId).notifier)
                          .updateStatus(_selectedStatus);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Order marked as $_selectedStatus')),
                        );
                      }
                    },
              child: controller.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Update Status'),
            ),
          ],
        ),
      ),
    );
  }
}
