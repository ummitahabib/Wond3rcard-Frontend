import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/add_members_params.dart';
import 'package:wond3rcard/src/organization/data/model/add_team_member_role.dart';
import 'package:wond3rcard/src/organization/data/model/change_role_model.dart';

class AddTeamMemberScreen extends ConsumerStatefulWidget {
  final String orgId;
  final String teamId;
  final List<String> availableMembers; // List of user IDs

  const AddTeamMemberScreen({
    Key? key,
    required this.orgId,
    required this.teamId,
    required this.availableMembers,
  }) : super(key: key);

  @override
  ConsumerState<AddTeamMemberScreen> createState() =>
      _AddTeamMemberScreenState();
}

class _AddTeamMemberScreenState extends ConsumerState<AddTeamMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedMemberId;
  MemberRole? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final addMemberParams =
        AddMemberParams(orgId: widget.orgId, teamId: widget.teamId);
    final addMemberNotifier = ref.read(addMemberToTeamProvider(addMemberParams).notifier);
    final addMemberState = ref.watch(addMemberToTeamProvider(addMemberParams));

    return Scaffold(
      appBar: AppBar(title: const Text('Add Team Member')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedMemberId,
                items: widget.availableMembers.map((memberId) {
                  return DropdownMenuItem(
                    value: memberId,
                    child: Text(memberId),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Select Member'),
                onChanged: (value) => setState(() => _selectedMemberId = value),
                validator: (value) =>
                    value == null ? 'Please select a member' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<MemberRole>(
                value: _selectedRole,
                items: MemberRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Select Role'),
                onChanged: (value) => setState(() => _selectedRole = value),
                validator: (value) =>
                    value == null ? 'Please select a role' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: addMemberState is AsyncLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final request = AddTeamMemberRequest(
                            memberId: _selectedMemberId!,
                            role: _selectedRole!.value,
                          );

                          await addMemberNotifier.addMember(request);

                          if (context.mounted) {
                            addMemberState.when(
                              data: (team) =>
                                  _showSuccessMessage(context, team),
                              error: (error, _) =>
                                  _showErrorMessage(context, error.toString()),
                              loading: () {},
                            );
                          }
                        }
                      },
                child: addMemberState is AsyncLoading
                    ? const CircularProgressIndicator()
                    : const Text('Add Member'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, Team team) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Member added to team "${team.name}"!')),
    );
    Navigator.pop(context);
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $message')),
    );
  }
}
