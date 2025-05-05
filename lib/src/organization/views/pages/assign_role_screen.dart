import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/assign_role_model.dart';
import 'package:wond3rcard/src/organization/data/model/assign_role_params.dart';
class AssignRoleScreen extends ConsumerStatefulWidget {
  final String orgId;
  final String teamId;
  final String memberId;

  const AssignRoleScreen({
    Key? key,
    required this.orgId,
    required this.teamId,
    required this.memberId,
  }) : super(key: key);

  @override
  ConsumerState<AssignRoleScreen> createState() => _AssignRoleScreenState();
}

class _AssignRoleScreenState extends ConsumerState<AssignRoleScreen> {
  TeamRole _selectedRole = TeamRole.member;
  bool _isLoading = false;

  void _assignRole() async {
    setState(() => _isLoading = true);

    try {
      final params = AssignRoleParams(
        orgId: widget.orgId,
        teamId: widget.teamId,
        memberId: widget.memberId,
        role: _selectedRole,
      );

      await ref.read(assignRoleProvider(params).future);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Role assigned successfully')),
      );
      Navigator.pop(context); // Return to previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Role')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Role',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButton<TeamRole>(
              value: _selectedRole,
              onChanged: (role) {
                if (role != null) {
                  setState(() {
                    _selectedRole = role;
                  });
                }
              },
              items: TeamRole.values.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role.name.toUpperCase()),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _assignRole,
                    child: const Text('Assign Role'),
                  ),
          ],
        ),
      ),
    );
  }
}
