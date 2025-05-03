// order_physical_card_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/order_physical_card_controller.dart';

class OrderPhysicalCardPage extends ConsumerStatefulWidget {
  const OrderPhysicalCardPage({super.key});

  @override
  ConsumerState<OrderPhysicalCardPage> createState() =>
      _OrderPhysicalCardPageState();
}

class _OrderPhysicalCardPageState
    extends ConsumerState<OrderPhysicalCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');

  String _region = 'nigeria';

  final String userId = "67ae134c1926fbabef30d9a3";
  final String physicalCardId = "67e3b0461ba63b0491c419e4";
  final String cardTemplateId = "6801fd47a321a7cac7ec64c2";

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderPhysicalCardControllerProvider);
    final controller = ref.read(orderPhysicalCardControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Order Physical Card")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _region,
                items: const [
                  DropdownMenuItem(value: "nigeria", child: Text("Nigeria")),
                  DropdownMenuItem(value: "other", child: Text("Other")),
                ],
                onChanged: (val) => setState(() => _region = val!),
                decoration: const InputDecoration(labelText: "Region"),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Quantity"),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              const SizedBox(height: 24),
              state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.createOrderAndPay(
                            userId: userId,
                            physicalCardId: physicalCardId,
                            cardTemplateId: cardTemplateId,
                            quantity: int.parse(_quantityController.text),
                            region: _region,
                            address: _addressController.text,
                            context: context,
                          );
                        }
                      },
                      child: const Text("Proceed to Payment"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
