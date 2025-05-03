import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/custom_card_controller.dart';

class UpdateCustomCardScreen extends ConsumerStatefulWidget {
  final String templateId;

  const UpdateCustomCardScreen({super.key, required this.templateId});

  @override
  ConsumerState<UpdateCustomCardScreen> createState() => _UpdateCustomCardScreenState();
}

class _UpdateCustomCardScreenState extends ConsumerState<UpdateCustomCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String priceNaira = '';
  String priceUsd = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updateCustomCardControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Update Custom Card')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (val) => name = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₦)'),
                keyboardType: TextInputType.number,
                onChanged: (val) => priceNaira = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (USD)'),
                keyboardType: TextInputType.number,
                onChanged: (val) => priceUsd = val,
              ),
              const SizedBox(height: 20),
              state.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(updateCustomCardControllerProvider.notifier).updateCustomCard(
                                templateId: widget.templateId,
                                name: name,
                                priceNaira: priceNaira,
                                priceUsd: priceUsd,
                              );
                        }
                      },
                      child: const Text('Update Card'),
                    ),
              if (state.hasError)
                Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
              if (state.value != null)
                Text('Card Updated ✅', style: const TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
}
