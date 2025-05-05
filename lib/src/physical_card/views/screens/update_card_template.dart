import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_template_controller.dart';

class UpdateCardTemplateScreen extends ConsumerStatefulWidget {
  final String templateId;

  const UpdateCardTemplateScreen({super.key, required this.templateId});

  @override
  ConsumerState<UpdateCardTemplateScreen> createState() => _UpdateCardTemplateScreenState();
}

class _UpdateCardTemplateScreenState extends ConsumerState<UpdateCardTemplateScreen> {
  final _formKey = GlobalKey<FormState>();
  String priceNaira = '';
  String priceUsd = '';
  PlatformFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updateTemplateControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Update Card Template')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₦)'),
                onChanged: (value) => priceNaira = value,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (USD)'),
                onChanged: (value) => priceUsd = value,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['svg'],
                    withData: true,
                  );
                  if (result != null && result.files.single.bytes != null) {
                    setState(() {
                      selectedFile = result.files.single;
                    });
                  }
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Choose New SVG'),
              ),
              if (selectedFile != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Selected: ${selectedFile!.name}'),
                ),
              const SizedBox(height: 20),
              state.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(updateTemplateControllerProvider.notifier).updateTemplate(
                                templateId: widget.templateId,
                                priceNaira: priceNaira,
                                priceUsd: priceUsd,
                                svgFile: selectedFile,
                              );
                        }
                      },
                      child: const Text('Update Template'),
                    ),
              if (state.hasError)
                Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
              if (state.value != null)
                Text('Template updated ✅', style: const TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
}
