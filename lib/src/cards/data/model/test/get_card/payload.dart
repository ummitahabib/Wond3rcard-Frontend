import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/getcard.dart';

import 'card.dart';

class Payload {
  List<CardData>? cards;

  Payload({this.cards});

  @override
  String toString() => 'Payload(cards: $cards)';

  factory Payload.fromMap(Map<String, dynamic> data) => Payload(
        cards: (data['cards'] as List<dynamic>?)
            ?.map((e) => CardData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'cards': cards?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Payload].
  factory Payload.fromJson(String data) {
    return Payload.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Payload] to a JSON string.
  String toJson() => json.encode(toMap());

  Payload copyWith({
    List<CardData>? cards,
  }) {
    return Payload(
      cards: cards ?? this.cards,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Payload) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => cards.hashCode;
}
