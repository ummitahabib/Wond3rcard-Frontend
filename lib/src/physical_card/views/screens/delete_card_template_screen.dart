import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_template_controller.dart';

class DeleteCardTemplateScreen extends ConsumerStatefulWidget {
  final String templateId;

  const DeleteCardTemplateScreen({super.key, required this.templateId});

  @override
  ConsumerState<DeleteCardTemplateScreen> createState() => _DeleteCardTemplateScreenState();
}

class _DeleteCardTemplateScreenState extends ConsumerState<DeleteCardTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deleteCardTemplateControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Delete Card Template')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Are you sure you want to delete this card template?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            state.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      ref.read(deleteCardTemplateControllerProvider.notifier).deleteCardTemplate(
                            templateId: widget.templateId,
                          );
                    },
                    child: const Text('Delete Template'),
                  ),
            const SizedBox(height: 20),
            if (state.hasError)
              Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
            if (state.value != null)
              Text(state.value!, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
