class CustomCardModel {
  final String id;
  final String name;
  final int priceNaira;
  final int priceUsd;

  CustomCardModel({
    required this.id,
    required this.name,
    required this.priceNaira,
    required this.priceUsd,
  });

  factory CustomCardModel.fromJson(Map<String, dynamic> json) {
    return CustomCardModel(
      id: json['_id'],
      name: json['name'],
      priceNaira: json['priceNaira'],
      priceUsd: json['priceUsd'],
    );
  }



  
}
