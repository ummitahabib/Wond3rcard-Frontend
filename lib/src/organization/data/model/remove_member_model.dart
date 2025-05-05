class RemoveMemberRequest {
  final String memberId;

  RemoveMemberRequest({required this.memberId});

  Map<String, dynamic> toJson() => {'memberId': memberId};
}


