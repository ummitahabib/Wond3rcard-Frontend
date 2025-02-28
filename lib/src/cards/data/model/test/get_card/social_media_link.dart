// import 'dart:convert';

// import 'package:collection/collection.dart';

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

//   @override
//   String toString() {
//     return 'SocialMediaLink(username: $username, active: $active, id: $id, linkedin: $linkedin, twitter: $twitter, facebook: $facebook, instagram: $instagram, tiktok: $tiktok, github: $github, youtube: $youtube, customLinks: $customLinks)';
//   }

//   factory SocialMediaLink.fromMap(Map<String, dynamic> data) {
//     return SocialMediaLink(
//       username: data['username'] as String?,
//       active: data['active'] as bool?,
//       id: data['_id'] as String?,
//       linkedin: data['linkedin'] as String?,
//       twitter: data['twitter'] as String?,
//       facebook: data['facebook'] as String?,
//       instagram: data['instagram'] as String?,
//       tiktok: data['tiktok'] as String?,
//       github: data['github'] as String?,
//       youtube: data['youtube'] as String?,
//       customLinks: data['customLinks'] as List<dynamic>?,
//     );
//   }

//   Map<String, dynamic> toMap() => {
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

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object as [SocialMediaLink].
//   factory SocialMediaLink.fromJson(String data) {
//     return SocialMediaLink.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [SocialMediaLink] to a JSON string.
//   String toJson() => json.encode(toMap());

//   SocialMediaLink copyWith({
//     String? username,
//     bool? active,
//     String? id,
//     String? linkedin,
//     String? twitter,
//     String? facebook,
//     String? instagram,
//     String? tiktok,
//     String? github,
//     String? youtube,
//     List<dynamic>? customLinks,
//   }) {
//     return SocialMediaLink(
//       username: username ?? this.username,
//       active: active ?? this.active,
//       id: id ?? this.id,
//       linkedin: linkedin ?? this.linkedin,
//       twitter: twitter ?? this.twitter,
//       facebook: facebook ?? this.facebook,
//       instagram: instagram ?? this.instagram,
//       tiktok: tiktok ?? this.tiktok,
//       github: github ?? this.github,
//       youtube: youtube ?? this.youtube,
//       customLinks: customLinks ?? this.customLinks,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     if (other is! SocialMediaLink) return false;
//     final mapEquals = const DeepCollectionEquality().equals;
//     return mapEquals(other.toMap(), toMap());
//   }

//   @override
//   int get hashCode =>
//       username.hashCode ^
//       active.hashCode ^
//       id.hashCode ^
//       linkedin.hashCode ^
//       twitter.hashCode ^
//       facebook.hashCode ^
//       instagram.hashCode ^
//       tiktok.hashCode ^
//       github.hashCode ^
//       youtube.hashCode ^
//       customLinks.hashCode;
// }
