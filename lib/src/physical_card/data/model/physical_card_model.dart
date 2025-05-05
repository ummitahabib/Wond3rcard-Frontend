class PhysicalCardModel {
  final String id;
  final String cardId;
  final String primaryColor;
  final String secondaryColor;
  final String finalDesign;
  final String status;
  final String createdAt;
  final CardTemplate cardTemplate;

  PhysicalCardModel({
    required this.id,
    required this.cardId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.finalDesign,
    required this.status,
    required this.createdAt,
    required this.cardTemplate,
  });

  factory PhysicalCardModel.fromJson(Map<String, dynamic> json) {
    return PhysicalCardModel(
      id: json['_id'],
      cardId: json['cardId'],
      primaryColor: json['primaryColor'],
      secondaryColor: json['secondaryColor'],
      finalDesign: json['finalDesign'],
      status: json['status'],
      createdAt: json['createdAt'],
      cardTemplate: CardTemplate.fromJson(json['cardTemplate']),
    );
  }
}

class CardTemplate {
  final String id;
  final String name;
  final int priceNaira;
  final int priceUsd;

  CardTemplate({
    required this.id,
    required this.name,
    required this.priceNaira,
    required this.priceUsd,
  });

  factory CardTemplate.fromJson(Map<String, dynamic> json) {
    return CardTemplate(
      id: json['_id'],
      name: json['name'],
      priceNaira: json['priceNaira'],
      priceUsd: json['priceUsd'],
    );
  }
}
