import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/member_model.dart';
import 'package:wond3rcard/src/organization/data/model/remove_member_model.dart';

class RemoveMemberScreen extends ConsumerWidget {
  final String orgId;

  const RemoveMemberScreen({Key? key, required this.orgId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgState = ref.watch(removeMemberProvider(orgId));
    final orgNotifier = ref.read(removeMemberProvider(orgId).notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Organization Members')),
      body: orgState.when(
        data: (organization) {
          if (organization.members.isEmpty) {
            return const Center(child: Text('No members found.'));
          }

          return ListView.builder(
            itemCount: organization.members.length,
            itemBuilder: (context, index) {
              final member = organization.members[index];
              return ListTile(
                title: Text('ID: ${member.memberId}'),
                subtitle: Text('Role: ${member.role}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => _confirmRemove(context, orgNotifier, member),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Future<void> _confirmRemove(
    BuildContext context,
    RemoveMemberNotifier notifier,
    Member member,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Member'),
        content: Text(
            'Are you sure you want to remove this member (${member.memberId})?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await notifier.removeMember(member.memberId);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Removed member: ${member.memberId}')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }
}
