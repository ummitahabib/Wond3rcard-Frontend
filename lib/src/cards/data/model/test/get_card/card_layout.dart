import 'dart:convert';

import 'package:collection/collection.dart';

class CardLayout {
  String? padding;
  String? margin;
  String? layoutOrientation;

  CardLayout({this.padding, this.margin, this.layoutOrientation});

  @override
  String toString() {
    return 'CardLayout(padding: $padding, margin: $margin, layoutOrientation: $layoutOrientation)';
  }

  factory CardLayout.fromMap(Map<String, dynamic> data) => CardLayout(
        padding: data['padding'] as String?,
        margin: data['margin'] as String?,
        layoutOrientation: data['layoutOrientation'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'padding': padding,
        'margin': margin,
        'layoutOrientation': layoutOrientation,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CardLayout].
  factory CardLayout.fromJson(String data) {
    return CardLayout.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CardLayout] to a JSON string.
  String toJson() => json.encode(toMap());

  CardLayout copyWith({
    String? padding,
    String? margin,
    String? layoutOrientation,
  }) {
    return CardLayout(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      layoutOrientation: layoutOrientation ?? this.layoutOrientation,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CardLayout) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      padding.hashCode ^ margin.hashCode ^ layoutOrientation.hashCode;
}
