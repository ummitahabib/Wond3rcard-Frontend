import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_template_controller.dart';

class TemplateDetailsScreen extends ConsumerWidget {
  final String templateId;

  const TemplateDetailsScreen({super.key, required this.templateId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(singleTemplateProvider(templateId));

    return Scaffold(
      appBar: AppBar(title: const Text("Template Details")),
      body: state.when(
        data: (template) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(template.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text("₦${template.priceNaira} / \$${template.priceUsd}"),
                const SizedBox(height: 12),
                if (template.design.isNotEmpty)
                  Center(
                    child: SvgPicture.network(
                      'https://your-api-url.com/${template.design}', // prepend base URL
                      placeholderBuilder: (context) => const CircularProgressIndicator(),
                      height: 200,
                    ),
                  )
                else
                  const Text("No design uploaded", style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Error: $error")),
      ),
    );
  }
}
