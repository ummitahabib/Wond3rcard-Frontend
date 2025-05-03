import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/create_team_model.dart';
import 'package:wond3rcard/src/organization/data/model/remove_team_members_params.dart';

class RemoveTeamMemberScreen extends ConsumerStatefulWidget {
  final String orgId;
  final String teamId;
  final List<TeamMember> members;

  const RemoveTeamMemberScreen({
    Key? key,
    required this.orgId,
    required this.teamId,
    required this.members,
  }) : super(key: key);

  @override
  ConsumerState<RemoveTeamMemberScreen> createState() =>
      _RemoveTeamMemberScreenState();
}

class _RemoveTeamMemberScreenState
    extends ConsumerState<RemoveTeamMemberScreen> {
  TeamMember? _selectedMember;
  bool _isLoading = false;

  void _removeMember() async {
    if (_selectedMember == null) return;

    setState(() => _isLoading = true);

    try {
      final params = RemoveTeamMemberParams(
        orgId: widget.orgId,
        teamId: widget.teamId,
        memberId: _selectedMember!.memberId,
      );

      await ref.read(removeTeamMemberProvider(params).future);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Member removed successfully')),
      );

      Navigator.pop(context); // Go back after success
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
      appBar: AppBar(title: const Text('Remove Team Member')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Member to Remove',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButton<TeamMember>(
              value: _selectedMember,
              hint: const Text('Select Member'),
              onChanged: (member) {
                setState(() {
                  _selectedMember = member;
                });
              },
              items: widget.members.map((member) {
                return DropdownMenuItem(
                  value: member,
                  child: Text('${member.memberId} (${member.role})'),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _removeMember,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Remove Member'),
                  ),
          ],
        ),
      ),
    );
  }
}
