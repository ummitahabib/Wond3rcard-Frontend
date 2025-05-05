import 'dart:convert';

import 'package:collection/collection.dart';

class CardDesign {
  String? backgroundColor;
  String? backgroundImage;
  String? borderStyle;
  String? borderColor;
  String? borderWidth;
  String? borderRadius;
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

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CardDesign].
  factory CardDesign.fromJson(String data) {
    return CardDesign.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CardDesign] to a JSON string.
  String toJson() => json.encode(toMap());

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
