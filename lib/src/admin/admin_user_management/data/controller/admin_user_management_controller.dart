


import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/model/get_all_users/payload.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/repository/admin_user_management.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

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

  GetAllUsersPayload? _getAllUsersPayload;
  GetAllUsersPayload? get getAllUsersPayload => _getAllUsersPayload;

  set getAllUsersPayload(GetAllUsersPayload? anal) {
    _getAllUsersPayload = anal;
    notifyListeners();
  }

  List<GetAllUsersPayload> _getAllUsersPayloadModel = [];

  List<GetAllUsersPayload> get getAllUsersPayloadModel => _getAllUsersPayloadModel;

  set getAllUsersPayloadModel(List<GetAllUsersPayload> usersLists) {
    _getAllUsersPayloadModel = usersLists;
    notifyListeners();
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  Future<GetAllUsersPayload?> getInteraction() async {
    try {
      loading = true;
      final response = await ref.read(adminUserManagementRepository).getAllUsers();
      loading = false;
      if (response.hasError()) {
        if (kDebugMode) {
          print('Error: ${response.error?.message ?? emptyString}');
        }
      } else {
        getAllUsersPayload = response.response ?? [];
        return getAllUsersPayload;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      loading = false;
    }
    return null;
  }
}
