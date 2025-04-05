import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/controller/organization_controller.dart';
import 'package:wond3rcard/src/organization/data/model/get_user_organization.dart';

// class UserOrganizationsScreen extends ConsumerWidget {
//   const UserOrganizationsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final organizationsAsync = ref.watch(userOrganizationsProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('User Organizations')),
//       body: organizationsAsync.when(
//         data: (organizations) {
//           if (organizations.isEmpty) {
//             return const Center(child: Text('No organizations found.'));
//           }

//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               columns: const [
//                 DataColumn(label: Text('Name')),
//                 DataColumn(label: Text('Business Type')),
//                 DataColumn(label: Text('Industry')),
//                 DataColumn(label: Text('Website')),
//                 DataColumn(label: Text('Created At')),
//                 DataColumn(label: Text('Actions')),
//               ],
//               rows: organizations.map((org) {
//                 return DataRow(cells: [
//                   DataCell(Text(org.name)),
//                   DataCell(Text(org.businessType)),
//                   DataCell(Text(org.industry)),
//                   DataCell(Text(org.companyWebsite)),
//                   DataCell(Text(org.createdAt.toLocal().toString())),
//                   DataCell(
//                     IconButton(
//                       icon: const Icon(Icons.info),
//                       onPressed: () {
//                         _showOrganizationDetails(context, org);
//                       },
//                     ),
//                   ),
//                 ]);
//               }).toList(),
//             ),
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, _) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }

//   // Show organization details in a dialog
//   void _showOrganizationDetails(BuildContext context, GetUserOrganization org) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(org.name),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Business Type: ${org.businessType}'),
//               Text('Industry: ${org.industry}'),
//               Text('Website: ${org.companyWebsite}'),
//               Text('Created At: ${org.createdAt.toLocal()}'),
//               const SizedBox(height: 16),
//               const Text('Members:', style: TextStyle(fontWeight: FontWeight.bold)),
//               ...org.members.map((m) => Text('- ${m.memberId} (${m.role})')).toList(),
//             ],
//           ),
//           actions: [
//             TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
//           ],
//         );
//       },
//     );
//   }
// }



class UserOrganizationsScreen extends ConsumerWidget {
  const UserOrganizationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizationsAsync = ref.watch(userOrganizationsProvider);
    final deleteNotifier = ref.read(deleteOrganizationProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('User Organizations')),
      body: organizationsAsync.when(
        data: (organizations) {
          if (organizations.isEmpty) {
            return const Center(child: Text('No organizations found.'));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Business Type')),
                DataColumn(label: Text('Industry')),
                DataColumn(label: Text('Website')),
                DataColumn(label: Text('Created At')),
              ],
              rows: organizations.map((org) {
                return DataRow(
                  cells: [
                    DataCell(_buildTapWidget(context, org, Text(org.name), deleteNotifier, ref)),
                    DataCell(Text(org.businessType)),
                    DataCell(Text(org.industry)),
                    DataCell(Text(org.companyWebsite)),
                    DataCell(Text(org.createdAt.toLocal().toString())),
                  ],
                );
              }).toList(),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  // Wrap the row with a GestureDetector for tap action
  Widget _buildTapWidget(BuildContext context, GetUserOrganization org, Widget child, DeleteOrganizationNotifier deleteNotifier, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _confirmAndDelete(context, org, deleteNotifier, ref),
      child: child,
    );
  }

  // Show confirmation dialog and delete if confirmed
  Future<void> _confirmAndDelete(BuildContext context, GetUserOrganization org, DeleteOrganizationNotifier deleteNotifier, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete "${org.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await deleteNotifier.deleteOrganization(org.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Deleted organization: ${org.name}')),
          );
          ref.invalidate(userOrganizationsProvider); // Refresh the list
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting organization: $e')),
          );
        }
      }
    }
  }
}
