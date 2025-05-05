import 'dart:convert';

class SocialMediaResponse {
  final String message;
  final List<SocialMedia> payload;

  SocialMediaResponse({
    required this.message,
    required this.payload,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'payload': payload.map((x) => x.toMap()).toList(),
    };
  }

  factory SocialMediaResponse.fromMap(Map<String, dynamic> map) {
    return SocialMediaResponse(
      message: map['message'] ?? '',
      payload: List<SocialMedia>.from(
          map['payload']?.map((x) => SocialMedia.fromMap(x)) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialMediaResponse.fromJson(String source) =>
      SocialMediaResponse.fromMap(json.decode(source));
}

class SocialMedia {
  final String? id;
  final String name;
  final String link;
  final String imageUrl;
  final String? description;
  final String? mediaType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SocialMedia({
    this.id,
    required this.name,
    required this.link,
    required this.imageUrl,
    this.description,
    this.mediaType,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'link': link,
      'imageUrl': imageUrl,
      'description': description,
      'mediaType': mediaType,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  factory SocialMedia.fromMap(Map<String, dynamic> map) {
    return SocialMedia(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      link: map['link'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'],
      mediaType: map['mediaType'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
  String toJson() => json.encode(toMap());
  factory SocialMedia.fromJson(String source) =>
      SocialMedia.fromMap(json.decode(source));
}
