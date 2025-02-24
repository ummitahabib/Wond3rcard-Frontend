import 'card.dart';

class Payload {
  List<Card>? cards;

  Payload({this.cards});

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        cards: (json['cards'] as List<dynamic>?)
            ?.map((e) => Card.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'cards': cards?.map((e) => e.toJson()).toList(),
      };
}
