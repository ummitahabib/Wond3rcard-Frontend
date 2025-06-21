import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'card_layout.g.dart';
@HiveType(typeId: 0)
class CardLayout extends HiveObject {
  @HiveField(0)
  String? padding;

  @HiveField(1)
  String? margin;

  @HiveField(2)
  String? layoutOrientation;

  CardLayout({this.padding, this.margin, this.layoutOrientation});

  Map<String, dynamic> toMap() {
    return {
      'padding': padding,
      'margin': margin,
      'layoutOrientation': layoutOrientation,
    };
  }

  factory CardLayout.fromMap(Map<String, dynamic> map) {
    return CardLayout(
      padding: map['padding'] as String?,
      margin: map['margin'] as String?,
      layoutOrientation: map['layoutOrientation'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardLayout.fromJson(String source) =>
      CardLayout.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardLayout(padding: $padding, margin: $margin, layoutOrientation: $layoutOrientation)';
  }

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
    return other.padding == padding &&
        other.margin == margin &&
        other.layoutOrientation == layoutOrientation;
  }

  @override
  int get hashCode =>
      padding.hashCode ^ margin.hashCode ^ layoutOrientation.hashCode;
}
