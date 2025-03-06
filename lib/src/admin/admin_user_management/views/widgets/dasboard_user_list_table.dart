// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:wond3rcard/src/admin/admin_user_management/data/model/user_model/user_model.dart';
// import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/user_type_filter.dart';
// import 'package:wond3rcard/src/utils/util.dart';

// class UserListTable extends HookConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final filteredUsers = ref.watch(filteredUsersProvider);
   
//    final ApiResponse? user;
//     return Container(
//       padding: EdgeInsets.zero,
//       child: _logTypeDataTable(user.payload.users),
//     );
//   }

//   Widget _logTypeDataTable(List<ApiResponse> users) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minWidth: constraints.maxWidth),
//             child: DataTable(
//               showCheckboxColumn: false,
//               columns: [
//                 DataColumn(label: _tableHeader('Profile')),
//                 DataColumn(label: _tableHeader('Name')),
//                 DataColumn(label: _tableHeader('Email')),
//                 DataColumn(label: _tableHeader('Role')),
//                 DataColumn(label: _tableHeader('Subscription Type')),
//                 DataColumn(label: _tableHeader('Status')),
//                 DataColumn(label: _tableHeader('Edit/Delete')),
//               ],
//               rows: users.map((user) => _buildDataRow(user)).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _tableHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }

//   DataRow _buildDataRow(ApiResponse user) {
//     return DataRow(
//       cells: [
//         DataCell(
//             CircleAvatar(backgroundImage: NetworkImage(ImageAssets.profileImage))),
//         DataCell(Text(user.payload.users.first.username)),
//         DataCell(Text(user.payload.users.first.email)),
//         DataCell(Text(user.payload.users.first.userRole)),
//         DataCell(Text(user.payload.users.first.userType)),
//         DataCell(_statusIndicator(user.payload.users.first.userStatus)),
//         DataCell(_actionIcons()),
//       ],
//     );
//   }

//   Widget _statusIndicator(String status) {
//     Color statusColor;
//     switch (status) {
//       case 'Active':
//         statusColor = Colors.green;
//         break;
//       case 'Inactive':
//         statusColor = Colors.grey;
//         break;
//       case 'Rejected':
//         statusColor = Colors.red;
//         break;
//       case 'Suspended':
//         statusColor = Colors.orange;
//         break;
//       default:
//         statusColor = Colors.black;
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
//       decoration: BoxDecoration(
//         color: statusColor.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Text(
//         status,
//         style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _actionIcons() {
//     return Row(
//       children: [
//         IconButton(
//             icon: Icon(Icons.edit, color: Colors.blue), onPressed: () {}),
//         IconButton(
//             icon: Icon(Icons.delete, color: Colors.red), onPressed: () {}),
//       ],
//     );
//   }
// }

