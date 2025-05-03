import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_controller.dart';

class CreatePhysicalCardScreen extends ConsumerStatefulWidget {
  const CreatePhysicalCardScreen({super.key});

  @override
  ConsumerState<CreatePhysicalCardScreen> createState() => _CreatePhysicalCardScreenState();
}

class _CreatePhysicalCardScreenState extends ConsumerState<CreatePhysicalCardScreen> {
  final _primaryColorController = TextEditingController(text: "#FF5733");
  final _secondaryColorController = TextEditingController(text: "#33FF57");

  // Replace with actual selected values
  final String userId = '67ae134c1926fbabef30d9a3';
  final String cardId = '6801fd47a321a7cac7ec64c2';
  final String templateId = '6801fd47a321a7cac7ec64c2';

  // Replace with your final updated SVG
  final String finalDesign = '''<svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 124 124" fill="none"><rect width="124" height="124" rx="24" fill="#F97316"/><path d="M19.375 36.7818V100.625C19.375 102.834 21.1659 104.625 23.375 104.625H87.2181C90.7818 104.625 92.5664 100.316 90.0466 97.7966L26.2034 33.9534C23.6836 31.4336 19.375 33.2182 19.375 36.7818Z" fill="white"/><circle cx="63.2109" cy="37.5391" r="18.1641" fill="black"/><rect opacity="0.4" x="81.1328" y="80.7198" width="17.5687" height="17.3876" rx="4" transform="rotate(-45 81.1328 80.7198)" fill="#FDBA74"/></svg>''';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(physicalCardControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Physical Card')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _primaryColorController,
              decoration: const InputDecoration(labelText: 'Primary Color'),
            ),
            TextField(
              controller: _secondaryColorController,
              decoration: const InputDecoration(labelText: 'Secondary Color'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(physicalCardControllerProvider.notifier).createCard(
                      userId: userId,
                      cardId: cardId,
                      templateId: templateId,
                      primaryColor: _primaryColorController.text,
                      secondaryColor: _secondaryColorController.text,
                      finalDesign: finalDesign,
                    );
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            if (state.isLoading)
              const CircularProgressIndicator()
            else if (state.hasError)
              Text('Error: ${state.error}', style: const TextStyle(color: Colors.red))
            else if (state.value != null)
              Text('Card Created!\nID: ${state.value!.id}', style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
