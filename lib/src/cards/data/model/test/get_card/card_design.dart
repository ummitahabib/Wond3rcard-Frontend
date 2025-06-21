import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'card_design.g.dart';

@HiveType(typeId: 1)
class CardDesign extends HiveObject {
  @HiveField(0)
  String? backgroundColor;

  @HiveField(1)
  String? backgroundImage;

  @HiveField(2)
  String? borderStyle;

  @HiveField(3)
  String? borderColor;

  @HiveField(4)
  String? borderWidth;

  @HiveField(5)
  String? borderRadius;

  @HiveField(6)
  String? boxShadow;

  CardDesign({
    this.backgroundColor,
    this.backgroundImage,
    this.borderStyle,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  String toString() {
    return 'CardDesign(backgroundColor: $backgroundColor, backgroundImage: $backgroundImage, borderStyle: $borderStyle, borderColor: $borderColor, borderWidth: $borderWidth, borderRadius: $borderRadius, boxShadow: $boxShadow)';
  }

  factory CardDesign.fromMap(Map<String, dynamic> data) => CardDesign(
        backgroundColor: data['backgroundColor'] as String?,
        backgroundImage: data['backgroundImage'] as String?,
        borderStyle: data['borderStyle'] as String?,
        borderColor: data['borderColor'] as String?,
        borderWidth: data['borderWidth'] as String?,
        borderRadius: data['borderRadius'] as String?,
        boxShadow: data['boxShadow'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'backgroundColor': backgroundColor,
        'backgroundImage': backgroundImage,
        'borderStyle': borderStyle,
        'borderColor': borderColor,
        'borderWidth': borderWidth,
        'borderRadius': borderRadius,
        'boxShadow': boxShadow,
      };

  CardDesign copyWith({
    String? backgroundColor,
    String? backgroundImage,
    String? borderStyle,
    String? borderColor,
    String? borderWidth,
    String? borderRadius,
    String? boxShadow,
  }) {
    return CardDesign(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      borderStyle: borderStyle ?? this.borderStyle,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CardDesign) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      backgroundImage.hashCode ^
      borderStyle.hashCode ^
      borderColor.hashCode ^
      borderWidth.hashCode ^
      borderRadius.hashCode ^
      boxShadow.hashCode;
}
