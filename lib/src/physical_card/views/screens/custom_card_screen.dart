import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/custom_card_controller.dart';

class CreateCustomCardScreen extends ConsumerStatefulWidget {
  const CreateCustomCardScreen({super.key});

  @override
  ConsumerState<CreateCustomCardScreen> createState() => _CreateCustomCardScreenState();
}

class _CreateCustomCardScreenState extends ConsumerState<CreateCustomCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String priceNaira = '';
  String priceUsd = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customCardControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Custom Card')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Card Name'),
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₦)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => priceNaira = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (USD)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => priceUsd = value,
              ),
              const SizedBox(height: 20),
              state.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(customCardControllerProvider.notifier)
                              .createCustomCard(
                                name: name,
                                priceNaira: priceNaira,
                                priceUsd: priceUsd,
                              );
                        }
                      },
                      child: const Text('Create Card'),
                    ),
              const SizedBox(height: 20),
              if (state.hasError)
                Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
              if (state.value != null)
                Text(
                  'Card "${state.value!.name}" created successfully! ✅',
                  style: const TextStyle(color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
