import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/model/user_model/user_model.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/repository/admin_user_management.dart';

final selectedUserTypeProvider = StateProvider<String>((ref) => "All");

final getAllUsersProvider = FutureProvider<List<ApiResponse>>((ref) async {
  final repository = ref.read(adminUserManagementRepository);
  final response = await repository.getAllUsers();

  if (response.hasError()) {
    debugPrint('Error: ${response.error?.message ?? "Unknown error"}');
    return [];
  }

  return response.response ?? [];
});

final filteredUsersProvider = Provider<List<ApiResponse>>((ref) {
  final selectedType = ref.watch(selectedUserTypeProvider);
  final allUsers = ref.watch(getAllUsersProvider).asData?.value ?? [];

  if (selectedType == "All") {
    return allUsers;
  }
  
  return allUsers.where((user) => user.payload.users.first.userType == selectedType).toList();
});

class UserTypeFilter extends ConsumerWidget {
  const UserTypeFilter({super.key});

  final List<String> userTypes = const ["All", "Basic", "Premium", "Organization"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(selectedUserTypeProvider);

    return Container(
      width: 410,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF6F6F6), Color(0xFFF2EFEF)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: userTypes.map((type) {
          final isSelected = selectedType == type;
          return GestureDetector(
            onTap: () => ref.read(selectedUserTypeProvider.notifier).state = type,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                type,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
