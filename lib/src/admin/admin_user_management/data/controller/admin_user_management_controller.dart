import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/model/user_model/user_model.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/repository/admin_user_management.dart';

final andminUserManagementProvider = ChangeNotifierProvider<AdminUserManagementNotifier>((ref) {
  return AdminUserManagementNotifier(ref);
});

class AdminUserManagementNotifier extends ChangeNotifier {
  final Ref ref;

  AdminUserManagementNotifier(this.ref);

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }

  List<ApiResponse> _userList = [];
  List<ApiResponse> get userList => _userList;

  set userList(List<ApiResponse> users) {
    _userList = users;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  Future<void> getAllUsers() async {
    try {
      loading = true;
      final resp = await ref.read(adminUserManagementRepository).getAllUsers();
      loading = false;

      if (resp.hasError()) {
        if (kDebugMode) {
          print('GET Users Error: ${resp.error?.message}');
        }
      } else {
        userList = resp.response ?? [];
        if (kDebugMode) {
          print('User list controller: $userList');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      loading = false;
    }
  }
}
