
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/controller/user_controller.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/model/user/user_model.dart';


class UserScreenManagement extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return userState.when(
      data: (users) {
        if (users.isEmpty) {
          return Center(child: Text("No users found."));
        }

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
                    DataColumn(label: _tableHeader('Username')),
                    DataColumn(label: _tableHeader('Email')),
                    DataColumn(label: _tableHeader('Role')),
                    DataColumn(label: _tableHeader('Subscription Type')),
                    DataColumn(label: _tableHeader('Status')),
                    DataColumn(label: _tableHeader('Actions')),
                  ],
                  rows: users.map((user) => _buildDataRow(user)).toList(),
                ),
              ),
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text("Error: ${error.toString()}")),
    );
  }

  /// Builds the table header with styling
  Widget _tableHeader(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  /// Builds a DataRow for each user
  DataRow _buildDataRow(User user) {
    return DataRow(
      cells: [
        DataCell(
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
        ),
        DataCell(Text(user.username)),
        DataCell(Text(user.email)),
        DataCell(Text(user.userRole.toUpperCase())),
        DataCell(Text(user.userTier.plan)),
        DataCell(_statusIndicator(user.userStatus)),
        DataCell(_actionIcons()),
      ],
    );
  }

  Widget _statusIndicator(String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'active':
        statusColor = Colors.green;
        break;
      case 'inactive':
        statusColor = Colors.grey;
        break;
      case 'rejected':
        statusColor = Colors.red;
        break;
      case 'suspended':
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

  /// Displays action buttons for edit/delete
  Widget _actionIcons() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            // Handle Edit Action
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Handle Delete Action
          },
        ),
      ],
    );
  }
}

