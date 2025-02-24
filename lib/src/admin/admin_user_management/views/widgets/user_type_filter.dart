import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/dasboard_user_list_table.dart';

final selectedUserTypeProvider = StateProvider<String>((ref) => "All");

final filteredUsersProvider = StateProvider<List<UserModel>>((ref) {
  final selectedType = ref.watch(selectedUserTypeProvider);
  if (selectedType == "All") {
    return dummyUsers;
  }
  return dummyUsers
      .where((user) => user.subscriptionType == selectedType)
      .toList();
});

class UserTypeFilter extends ConsumerWidget {
  final List<String> userTypes = ["All", "Basic", "Premium", "Organization"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(selectedUserTypeProvider);

    return Container(
      width: 410,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
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
            onTap: () {
              ref.read(selectedUserTypeProvider.notifier).state = type;
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
