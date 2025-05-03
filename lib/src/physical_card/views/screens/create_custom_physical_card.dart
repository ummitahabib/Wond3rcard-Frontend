import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/custom_physical_card_controller.dart';

class CreateCustomPhysicalCardScreen extends ConsumerStatefulWidget {
  const CreateCustomPhysicalCardScreen({super.key});

  @override
  ConsumerState<CreateCustomPhysicalCardScreen> createState() =>
      _CreateCustomPhysicalCardScreenState();
}

class _CreateCustomPhysicalCardScreenState
    extends ConsumerState<CreateCustomPhysicalCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _primaryColorController = TextEditingController(text: "#000000");
  final _secondaryColorController = TextEditingController(text: "#ffffff");

  PlatformFile? _selectedPlatformFile;

  final String userId = '67cd91eb0fc52713fbd97b26';
  final String cardId = '67cd98b19338ff2254e8a492';
  final String templateId = '67e3af731ba63b0491c419d9';

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg', 'pdf'],
      withData: true, // VERY IMPORTANT FOR WEB
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedPlatformFile = result.files.first;
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() && _selectedPlatformFile != null) {
      await ref
          .read(customPhysicalCardControllerProvider.notifier)
          .createCard(
            userId: userId,
            cardId: cardId,
            templateId: templateId,
            primaryColor: _primaryColorController.text,
            secondaryColor: _secondaryColorController.text,
            platformFile: _selectedPlatformFile!,
          );

      final state = ref.read(customPhysicalCardControllerProvider);
      if (state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Upload failed")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Card uploaded successfully!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete form and upload a file")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customPhysicalCardControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Custom Card Upload")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _primaryColorController,
                decoration: const InputDecoration(labelText: "Primary Color"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _secondaryColorController,
                decoration: const InputDecoration(labelText: "Secondary Color"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickFile,
                child: const Text("Upload Final Design (jpg/png/svg/pdf)"),
              ),
              if (_selectedPlatformFile != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("Selected: ${_selectedPlatformFile!.name}"),
                ),
              const SizedBox(height: 20),
              state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submit,
                      child: const Text("Submit Card"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
