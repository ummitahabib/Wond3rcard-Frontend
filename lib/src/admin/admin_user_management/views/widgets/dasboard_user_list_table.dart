import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/user_type_filter.dart';

class UserListTable extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredUsers = ref.watch(filteredUsersProvider);

    return Container(
      padding: EdgeInsets.zero,
      child: _logTypeDataTable(filteredUsers),
    );
  }

  Widget _logTypeDataTable(List<UserModel> users) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              showCheckboxColumn: false,
              columns: [
                DataColumn(label: _tableHeader('Profile')),
                DataColumn(label: _tableHeader('Name')),
                DataColumn(label: _tableHeader('Email')),
                DataColumn(label: _tableHeader('Role')),
                DataColumn(label: _tableHeader('Subscription Type')),
                DataColumn(label: _tableHeader('Status')),
                DataColumn(label: _tableHeader('Edit/Delete')),
              ],
              rows: users.map((user) => _buildDataRow(user)).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _tableHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  DataRow _buildDataRow(UserModel user) {
    return DataRow(
      cells: [
        DataCell(
            CircleAvatar(backgroundImage: NetworkImage(user.profileImage))),
        DataCell(Text(user.name)),
        DataCell(Text(user.email)),
        DataCell(Text(user.role)),
        DataCell(Text(user.subscriptionType)),
        DataCell(_statusIndicator(user.status)),
        DataCell(_actionIcons()),
      ],
    );
  }

  Widget _statusIndicator(String status) {
    Color statusColor;
    switch (status) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Inactive':
        statusColor = Colors.grey;
        break;
      case 'Rejected':
        statusColor = Colors.red;
        break;
      case 'Suspended':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.black;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _actionIcons() {
    return Row(
      children: [
        IconButton(
            icon: Icon(Icons.edit, color: Colors.blue), onPressed: () {}),
        IconButton(
            icon: Icon(Icons.delete, color: Colors.red), onPressed: () {}),
      ],
    );
  }
}

class UserModel {
  final String profileImage;
  final String name;
  final String email;
  final String role;
  final String subscriptionType;
  final String status;

  UserModel({
    required this.profileImage,
    required this.name,
    required this.email,
    required this.role,
    required this.subscriptionType,
    required this.status,
  });
}

List<UserModel> dummyUsers = [
  UserModel(
    profileImage: 'https://via.placeholder.com/50',
    name: 'John Doe',
    email: 'john.doe@example.com',
    role: 'Admin',
    subscriptionType: 'Premium',
    status: 'Active',
  ),
  UserModel(
    profileImage: 'https://via.placeholder.com/50',
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    role: 'User',
    subscriptionType: 'Basic',
    status: 'Inactive',
  ),
  UserModel(
    profileImage: 'https://via.placeholder.com/50',
    name: 'Michael Johnson',
    email: 'michael.johnson@example.com',
    role: 'Moderator',
    subscriptionType: 'Organization',
    status: 'Rejected',
  ),
  UserModel(
    profileImage: 'https://via.placeholder.com/50',
    name: 'Emily Davis',
    email: 'emily.davis@example.com',
    role: 'Admin',
    subscriptionType: 'Premium',
    status: 'Suspended',
  ),
];
