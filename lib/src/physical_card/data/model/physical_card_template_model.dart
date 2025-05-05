class CardTemplateModel {
  final String id;
  final String name;
  final String design;
  final int priceNaira;
  final int priceUsd;

  CardTemplateModel({
    required this.id,
    required this.name,
    required this.design,
    required this.priceNaira,
    required this.priceUsd,
  });

  factory CardTemplateModel.fromJson(Map<String, dynamic> json) {
    return CardTemplateModel(
      id: json['_id'],
      name: json['name'],
      design: json['design'],
      priceNaira: json['priceNaira'],
      priceUsd: json['priceUsd'],
    );
  }
}
