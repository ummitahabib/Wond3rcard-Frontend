import 'dart:convert';

class Font {
  final String? id;
  final String name;
  final String? type;

  Font({
    this.id,
    required this.name,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }

  factory Font.fromMap(Map<String, dynamic> map) {
    return Font(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Font.fromJson(String source) => Font.fromMap(json.decode(source));
}
