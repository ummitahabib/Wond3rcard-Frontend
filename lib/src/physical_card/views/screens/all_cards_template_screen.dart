import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_template_controller.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AllCardTemplatesScreen extends ConsumerWidget {
  const AllCardTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cardTemplateListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("All Card Templates")),
      body: state.when(
        data: (templates) {
          if (templates.isEmpty) {
            return const Center(child: Text("No templates found."));
          }

          return ListView.builder(
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(template.name),
                  subtitle: Text("₦${template.priceNaira} / \$${template.priceUsd}"),
                  trailing: SizedBox(
                    width: 60,
                    height: 60,
                    child: template.design.isNotEmpty
                        ? SvgPicture.network(
                            'https://wond3rcard-backend.onrender.com/api/${template.design}',
                            placeholderBuilder: (context) =>
                                const CircularProgressIndicator(),
                            width: 60,
                            height: 60,
                          )
                        : const Icon(Icons.image_not_supported),
                  ),
                  onTap: () {
                    // Navigate or preview if needed
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
