class CreateFlagRequest {
  final String name;

  CreateFlagRequest({required this.name});

  factory CreateFlagRequest.fromJson(Map<String, dynamic> json) {
    return CreateFlagRequest(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
