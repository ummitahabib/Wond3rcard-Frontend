import 'package:wond3rcard/src/utils/size_constants.dart';

enum UserRole { customer, admin, moderator, unknown }

enum UserType { normal, premium, team, business, unknown }

extension UserRoleExtension on UserRole {
  int getValue() {
    switch (this) {
      case UserRole.unknown:
        return SpacingConstants.int0;
      case UserRole.customer:
        return SpacingConstants.int1;
      case UserRole.admin:
        return SpacingConstants.int2;
      case UserRole.moderator:
        return SpacingConstants.int3;
    }
  }
}

int getUserRoleFromString(String? role) {
  switch (role) {
    case "customer":
      return SpacingConstants.int1;
    case "admin":
      return SpacingConstants.int2;
    case "moderator":
      return SpacingConstants.int3;
    default:
      return SpacingConstants.int0;
  }
}
