class SuggestedUser {
  final String id;
  final String uid;
  final String firstname;
  final String othername;
  final String lastname;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String profileUrl;
  final String coverUrl;
  final List<String> contacts;
  final List<String> connections;

  SuggestedUser({
    required this.id,
    required this.uid,
    required this.firstname,
    required this.othername,
    required this.lastname,
    required this.email,
    required this.mobileNumber,
    required this.companyName,
    required this.designation,
    required this.profileUrl,
    required this.coverUrl,
    required this.contacts,
    required this.connections,
  });

  factory SuggestedUser.fromJson(Map<String, dynamic> json) {
    return SuggestedUser(
      id: json['_id'],
      uid: json['uid'],
      firstname: json['firstname'],
      othername: json['othername'],
      lastname: json['lastname'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      companyName: json['companyName'],
      designation: json['designation'],
      profileUrl: json['profileUrl'],
      coverUrl: json['coverUrl'],
      contacts: List<String>.from(json['contacts'] ?? []),
      connections: List<String>.from(json['connections'] ?? []),
    );
  }
}
