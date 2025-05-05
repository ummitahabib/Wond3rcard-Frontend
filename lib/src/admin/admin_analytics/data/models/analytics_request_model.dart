class AdminAnalyticsRequestModel {
  final String name;

  AdminAnalyticsRequestModel({required this.name});

  factory AdminAnalyticsRequestModel.fromJson(Map<String, dynamic> json) {
    return AdminAnalyticsRequestModel(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
