class RemoveTeamMemberParams {
  final String orgId;
  final String teamId;
  final String memberId;

  RemoveTeamMemberParams({
    required this.orgId,
    required this.teamId,
    required this.memberId,
  });
}