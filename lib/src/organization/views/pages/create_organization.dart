import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/create_organization_request.dart';

class CreateOrganizationScreen extends ConsumerStatefulWidget {
  const CreateOrganizationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateOrganizationScreen> createState() =>
      _CreateOrganizationScreenState();
}

class _CreateOrganizationScreenState
    extends ConsumerState<CreateOrganizationScreen> {
  final _nameController = TextEditingController();
  final _industryController = TextEditingController();
  final _websiteController = TextEditingController();
  final _memberIdController = TextEditingController();

  final List<String> businessTypes = [
    "LLC",
    "Corporation",
    "Nonprofit",
    "Startup"
  ];
  String _selectedBusinessType = "Startup";

  void _submit() {
    final request = CreateOrganizationRequest(
      name: _nameController.text,
      businessType: _selectedBusinessType,
      industry: _industryController.text,
      companyWebsite: _websiteController.text,
      memberId: _memberIdController.text,
    );

    ref.read(createOrganizationProvider.notifier).createOrganization(request);
  }

  @override
  Widget build(BuildContext context) {
    final organizationState = ref.watch(createOrganizationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Organization')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Organization Name'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedBusinessType,
              decoration: const InputDecoration(labelText: 'Business Type'),
              items: businessTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedBusinessType = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _industryController,
              decoration: const InputDecoration(labelText: 'Industry'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _websiteController,
              decoration: const InputDecoration(labelText: 'Company Website'),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _memberIdController,
              decoration: const InputDecoration(labelText: 'Member ID'),
            ),
            const SizedBox(height: 20),
            organizationState.when(
              data: (organization) {
                if (organization != null) {
                  return Text(
                    'Organization Created: ${organization.name}',
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  );
                }
                return const SizedBox.shrink();
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('Error: $error',
                  style: const TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Create Organization'),
            ),
          ],
        ),
      ),
    );
  }
}
