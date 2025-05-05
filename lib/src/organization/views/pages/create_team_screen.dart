import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/create_team_model.dart';
class CreateTeamScreen extends ConsumerStatefulWidget {
  final String orgId;
  final List<String> userIds; // Pass a list of users for lead selection

  const CreateTeamScreen({
    Key? key,
    required this.orgId,
    required this.userIds,
  }) : super(key: key);

  @override
  ConsumerState<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends ConsumerState<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedLeadId;

  @override
  Widget build(BuildContext context) {
    final createTeamState = ref.watch(createTeamProvider(widget.orgId));
    final createTeamNotifier = ref.read(createTeamProvider(widget.orgId).notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Team')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Team Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Team name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Description is required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedLeadId,
                decoration: const InputDecoration(labelText: 'Select Team Lead'),
                items: widget.userIds.map((userId) {
                  return DropdownMenuItem(
                    value: userId,
                    child: Text(userId),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedLeadId = value),
                validator: (value) =>
                    value == null ? 'Please select a team lead' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: createTeamState is AsyncLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final request = CreateTeamRequest(
                            name: _nameController.text,
                            description: _descriptionController.text,
                            leadId: _selectedLeadId!,
                          );

                          await createTeamNotifier.createTeam(request);

                          if (context.mounted) {
                            createTeamState.when(
                              data: (team) => _showSuccessMessage(context, team),
                              error: (error, _) =>
                                  _showErrorMessage(context, error.toString()),
                              loading: () {},
                            );
                          }
                        }
                      },
                child: createTeamState is AsyncLoading
                    ? const CircularProgressIndicator()
                    : const Text('Create Team'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, TeamModel team) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Team "${team.name}" created successfully!')),
    );
    Navigator.pop(context);
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $message')),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
