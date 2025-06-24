class CardTemplateModel {
  final String id;
  final String name;
  final String design;
  final int priceNaira;
  final int priceUsd;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  CardTemplateModel({
    required this.id,
    required this.name,
    required this.design,
    required this.priceNaira,
    required this.priceUsd,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CardTemplateModel.fromJson(Map<String, dynamic> json) {
    return CardTemplateModel(
      id: json['_id'],
      name: json['name'],
      design: json['design'],
      priceNaira: json['priceNaira'],
      priceUsd: json['priceUsd'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  CardTemplateModel copyWith({
    String? id,
    String? name,
    String? design,
    int? priceNaira,
    int? priceUsd,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CardTemplateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      design: design ?? this.design,
      priceNaira: priceNaira ?? this.priceNaira,
      priceUsd: priceUsd ?? this.priceUsd,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
