import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/add_member_model.dart';

class AddMemberScreen extends ConsumerStatefulWidget {
  final String orgId;

  const AddMemberScreen({Key? key, required this.orgId}) : super(key: key);

  @override
  ConsumerState<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends ConsumerState<AddMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _memberIdController = TextEditingController();
  String _selectedRole = 'member';

  final List<String> roles = ['admin', 'lead', 'moderator', 'member'];

  void _addMember() {
    if (_formKey.currentState!.validate()) {
      final request = AddMemberRequest(
        memberId: _memberIdController.text.trim(),
        role: _selectedRole,
      );

      ref
          .read(addMemberProvider.notifier)
          .addMember(orgId: widget.orgId, request: request);
    }
  }

  @override
  Widget build(BuildContext context) {
    final addMemberState = ref.watch(addMemberProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Member to Organization')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Member ID', style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _memberIdController,
                decoration: const InputDecoration(
                  hintText: 'Enter Member ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter Member ID' : null,
              ),
              const SizedBox(height: 20),
              const Text('Role', style: TextStyle(fontSize: 16)),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: roles.map((role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList(),
                onChanged: (value) => setState(() => _selectedRole = value!),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 30),
              addMemberState.maybeWhen(
                loading: () => const CircularProgressIndicator(),
                data: (organization) => organization != null
                    ? Text("Member added to ${organization.name}")
                    : Container(),
                orElse: () => ElevatedButton(
                  onPressed: _addMember,
                  child: const Text('Add Member'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
