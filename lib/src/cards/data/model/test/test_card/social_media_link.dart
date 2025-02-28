// class SocialMediaLink {
//   String? username;
//   bool? active;
//   String? id;
//   String? linkedin;
//   String? twitter;
//   String? facebook;
//   String? instagram;
//   String? tiktok;
//   String? github;
//   String? youtube;
//   List<dynamic>? customLinks;

//   SocialMediaLink({
//     this.username,
//     this.active,
//     this.id,
//     this.linkedin,
//     this.twitter,
//     this.facebook,
//     this.instagram,
//     this.tiktok,
//     this.github,
//     this.youtube,
//     this.customLinks,
//   });

//   factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
//     return SocialMediaLink(
//       username: json['username'] as String?,
//       active: json['active'] as bool?,
//       id: json['_id'] as String?,
//       linkedin: json['linkedin'] as String?,
//       twitter: json['twitter'] as String?,
//       facebook: json['facebook'] as String?,
//       instagram: json['instagram'] as String?,
//       tiktok: json['tiktok'] as String?,
//       github: json['github'] as String?,
//       youtube: json['youtube'] as String?,
//       customLinks: json['customLinks'] as List<dynamic>?,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'username': username,
//         'active': active,
//         '_id': id,
//         'linkedin': linkedin,
//         'twitter': twitter,
//         'facebook': facebook,
//         'instagram': instagram,
//         'tiktok': tiktok,
//         'github': github,
//         'youtube': youtube,
//         'customLinks': customLinks,
//       };
// }
