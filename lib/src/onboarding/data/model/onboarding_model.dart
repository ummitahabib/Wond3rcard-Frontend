class OnboardingModel {
  final String firstName;
  final String lastName;
  final String workEmail;
  final String phoneNumber;
  final String companyName;
  final String jobTitle;
  final String website;
  final String photo;

  OnboardingModel({
    required this.firstName,
    required this.lastName,
    required this.workEmail,
    required this.phoneNumber,
    required this.companyName,
    required this.jobTitle,
    required this.website,
    required this.photo,
  });

  OnboardingModel copyWith({
    String? firstName,
    String? lastName,
    String? workEmail,
    String? phoneNumber,
    String? companyName,
    String? jobTitle,
    String? website,
    String? photo,
  }) {
    return OnboardingModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      workEmail: workEmail ?? this.workEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      companyName: companyName ?? this.companyName,
      jobTitle: jobTitle ?? this.jobTitle,
      website: website ?? this.website,
      photo: photo ?? this.photo,
    );
  }
}
