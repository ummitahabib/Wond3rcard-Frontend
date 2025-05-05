import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/change_role_model.dart';

class ChangeRoleScreen extends ConsumerWidget {
  final String orgId;

  const ChangeRoleScreen({Key? key, required this.orgId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgState = ref.watch(changeRoleProvider(orgId));
    final orgNotifier = ref.read(changeRoleProvider(orgId).notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Change Member Role')),
      body: orgState.when(
        data: (organization) {
          if (organization.members.isEmpty) {
            return const Center(child: Text('No members available.'));
          }

          return ListView.builder(
            itemCount: organization.members.length,
            itemBuilder: (context, index) {
              final member = organization.members[index];
              return ListTile(
                title: Text('ID: ${member.memberId}'),
                subtitle: Text('Role: ${member.role.name}'),
                trailing: _buildRoleDropdown(member, orgNotifier, context),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildRoleDropdown(
    MemberModel member,
    ChangeRoleNotifier notifier,
    BuildContext context,
  ) {
    return DropdownButton<MemberRoleEnum>(
      value: member.role,
      items: MemberRoleEnum.values.map((role) {
        return DropdownMenuItem(
          value: role,
          child: Text(role.name.toUpperCase()),
        );
      }).toList(),
      onChanged: (newRole) async {
        if (newRole != null && newRole != member.role) {
          final confirm =
              await _showConfirmationDialog(context, member, newRole);
          if (confirm) {
            await notifier.changeRole(member.memberId, newRole);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Role updated to ${newRole.name}')),
              );
            }
          }
        }
      },
    );
  }

  Future<bool> _showConfirmationDialog(
    BuildContext context,
    MemberModel member,
    MemberRoleEnum newRole,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Change Member Role'),
            content: Text(
              'Are you sure you want to change the role of member (${member.memberId}) to ${newRole.name.toUpperCase()}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child:
                    const Text('Confirm', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ) ??
        false;
  }
}
