import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/get_team_members_model.dart';
import 'package:wond3rcard/src/organization/data/model/team_params.dart';

class TeamMembersScreen extends ConsumerWidget {
  final String orgId;
  final String teamId;

  const TeamMembersScreen({
    Key? key,
    required this.orgId,
    required this.teamId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamParams = TeamParams(orgId: orgId, teamId: teamId);
    final teamMembersAsync = ref.watch(teamMembersProvider(teamParams));

    return Scaffold(
      appBar: AppBar(title: const Text('Team Members')),
      body: teamMembersAsync.when(
        data: (team) => _buildMemberList(context, team),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildMemberList(BuildContext context, GetTeamMembers team) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Team: ${team.name}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text('Description: ${team.description}'),
          const SizedBox(height: 16),
          const Text('Members:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: team.members.length,
              itemBuilder: (context, index) {
                final member = team.members[index];
                return Card(
                  child: ListTile(
                    title: Text('Member ID: ${member.memberId}'),
                    subtitle: Text('Role: ${member.role}'),
                    leading: const Icon(Icons.person),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
