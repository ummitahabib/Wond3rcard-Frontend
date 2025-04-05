import 'package:wond3rcard/src/utils/size_constants.dart';

// enum UserRole { customer, admin, moderator, unknown }

enum UserType { normal, premium, team, business, admin, unknown }

extension UserRoleExtension on UserType {
  int getValue() {
    switch (this) {
      case UserType.normal:
        return SpacingConstants.int0;
      case UserType.premium:
        return SpacingConstants.int1;
      case UserType.team:
        return SpacingConstants.int2;
           case UserType.business:
        return SpacingConstants.int3;
              case UserType.admin:
        return SpacingConstants.int4;
                   case UserType.unknown:
        return SpacingConstants.int5;
    }
  }
}

int getUserRoleFromString(String? role) {
  switch (role) {
    case "normal":
      return SpacingConstants.int0;
    case "premium":
      return SpacingConstants.int1;
          case "team":
      return SpacingConstants.int2;
    case "business":
      return SpacingConstants.int3;
          case "admin":
      return SpacingConstants.int4;
    default:
      return SpacingConstants.int5;
  }
}
