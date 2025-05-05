import 'package:wond3rcard/src/organization/data/model/assign_role_model.dart';

class AssignRoleParams {
  final String orgId;
  final String teamId;
  final String memberId;
  final TeamRole role;

  AssignRoleParams({
    required this.orgId,
    required this.teamId,
    required this.memberId,
    required this.role,
  });
}
