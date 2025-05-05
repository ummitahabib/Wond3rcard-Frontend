import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_template_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class CreateCardTemplateScreen extends ConsumerStatefulWidget {
  const CreateCardTemplateScreen({super.key});

  @override
  ConsumerState<CreateCardTemplateScreen> createState() => _CreateCardTemplateScreenState();
}

class _CreateCardTemplateScreenState extends ConsumerState<CreateCardTemplateScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String priceNaira = '';
  String priceUsd = '';
  PlatformFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cardTemplateControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Card Template')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
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
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['svg'],
                    withData: kIsWeb, // Needed for web to get bytes
                  );

                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      selectedFile = result.files.single;
                    });
                  }
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Choose SVG File'),
              ),
              if (selectedFile != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Selected: ${selectedFile!.name}'),
                ),
              const SizedBox(height: 20),
              state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && selectedFile != null) {
                          ref.read(cardTemplateControllerProvider.notifier).createCardTemplate(
                                name: name,
                                priceNaira: priceNaira,
                                priceUsd: priceUsd,
                                file: selectedFile!,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill all fields and choose a file')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
                ),
              if (state.value != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Card Template Created: ${state.value!.name} ✅',
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
