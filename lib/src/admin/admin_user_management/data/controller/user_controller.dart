import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/model/user/user_model.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/repository/user_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userProvider = FutureProvider<List<User>>((ref) async {
  final repository = ref.read(userRepositoryProvider);
  return repository.fetchUsers();
});
