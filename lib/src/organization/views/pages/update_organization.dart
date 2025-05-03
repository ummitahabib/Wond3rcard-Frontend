import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/update_organization_request.dart';

class UpdateOrganizationScreen extends ConsumerStatefulWidget {
  final String orgId;
  final String creatorId;

  const UpdateOrganizationScreen({
    super.key,
    required this.orgId,
    required this.creatorId,
  });

  @override
  ConsumerState<UpdateOrganizationScreen> createState() => _UpdateOrganizationScreenState();
}

class _UpdateOrganizationScreenState extends ConsumerState<UpdateOrganizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  String _businessType = "LLC";
  final List<String> businessTypes = ["LLC", "Corporation", "Nonprofit", "Startup"];

  @override
  Widget build(BuildContext context) {
    final updateState = ref.watch(updateOrganizationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Update Organization")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Organization Name"),
                validator: (value) => value!.isEmpty ? "Name is required" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _businessType,
                onChanged: (value) => setState(() => _businessType = value!),
                items: businessTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                decoration: const InputDecoration(labelText: "Business Type"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _industryController,
                decoration: const InputDecoration(labelText: "Industry"),
                validator: (value) => value!.isEmpty ? "Industry is required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(labelText: "Company Website"),
                validator: (value) => value!.isEmpty ? "Website is required" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: updateState.isLoading ? null : _submitForm,
                child: updateState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Update"),
              ),
              if (updateState.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    "Error: ${updateState.error}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              if (updateState.value != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    "Updated successfully: ${updateState.value!.name}",
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final request = UpdateOrganizationRequest(
        name: _nameController.text,
        businessType: _businessType,
        industry: _industryController.text,
        companyWebsite: _websiteController.text,
        creatorId: widget.creatorId,
      );

      ref
          .read(updateOrganizationProvider.notifier)
          .updateOrganization(orgId: widget.orgId, request: request);
    }
  }
}
