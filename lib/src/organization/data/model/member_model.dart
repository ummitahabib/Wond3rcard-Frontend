class Member {
  final String memberId;
  final String role;
  final String id;

  Member({
    required this.memberId,
    required this.role,
    required this.id,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberId: json['memberId'],
      role: json['role'],
      id: json['_id'],
    );
  }
}
