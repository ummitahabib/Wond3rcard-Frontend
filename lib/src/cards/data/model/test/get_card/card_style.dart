import 'dart:convert';

import 'package:collection/collection.dart';

class CardStyle {
  String? fontSize;
  String? fontStyle;
  String? fontWeight;
  String? textAlign;
  String? textColor;
  String? borderStyle;
  String? borderColor;
  String? borderWidth;
  String? borderRadius;
  String? padding;
  String? margin;
  String? orientation;
  String? alignment;
  String? boxShadow;
  String? primaryColor;
  String? secondaryColor;

  CardStyle({
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.textAlign,
    this.textColor,
    this.borderStyle,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.margin,
    this.orientation,
    this.alignment,
    this.boxShadow,
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  String toString() {
    return 'CardStyle(fontSize: $fontSize, fontStyle: $fontStyle, fontWeight: $fontWeight, textAlign: $textAlign, textColor: $textColor, borderStyle: $borderStyle, borderColor: $borderColor, borderWidth: $borderWidth, borderRadius: $borderRadius, padding: $padding, margin: $margin, orientation: $orientation, alignment: $alignment, boxShadow: $boxShadow, primaryColor: $primaryColor, secondaryColor: $secondaryColor)';
  }

  factory CardStyle.fromMap(Map<String, dynamic> data) => CardStyle(
        fontSize: data['fontSize'] as String?,
        fontStyle: data['fontStyle'] as String?,
        fontWeight: data['fontWeight'] as String?,
        textAlign: data['textAlign'] as String?,
        textColor: data['textColor'] as String?,
        borderStyle: data['borderStyle'] as String?,
        borderColor: data['borderColor'] as String?,
        borderWidth: data['borderWidth'] as String?,
        borderRadius: data['borderRadius'] as String?,
        padding: data['padding'] as String?,
        margin: data['margin'] as String?,
        orientation: data['orientation'] as String?,
        alignment: data['alignment'] as String?,
        boxShadow: data['boxShadow'] as String?,
        primaryColor: data['primaryColor'] as String?,
        secondaryColor: data['secondaryColor'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'fontSize': fontSize,
        'fontStyle': fontStyle,
        'fontWeight': fontWeight,
        'textAlign': textAlign,
        'textColor': textColor,
        'borderStyle': borderStyle,
        'borderColor': borderColor,
        'borderWidth': borderWidth,
        'borderRadius': borderRadius,
        'padding': padding,
        'margin': margin,
        'orientation': orientation,
        'alignment': alignment,
        'boxShadow': boxShadow,
        'primaryColor': primaryColor,
        'secondaryColor': secondaryColor,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CardStyle].
  factory CardStyle.fromJson(String data) {
    return CardStyle.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CardStyle] to a JSON string.
  String toJson() => json.encode(toMap());

  CardStyle copyWith({
    String? fontSize,
    String? fontStyle,
    String? fontWeight,
    String? textAlign,
    String? textColor,
    String? borderStyle,
    String? borderColor,
    String? borderWidth,
    String? borderRadius,
    String? padding,
    String? margin,
    String? orientation,
    String? alignment,
    String? boxShadow,
    String? primaryColor,
    String? secondaryColor,
  }) {
    return CardStyle(
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
      fontWeight: fontWeight ?? this.fontWeight,
      textAlign: textAlign ?? this.textAlign,
      textColor: textColor ?? this.textColor,
      borderStyle: borderStyle ?? this.borderStyle,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      orientation: orientation ?? this.orientation,
      alignment: alignment ?? this.alignment,
      boxShadow: boxShadow ?? this.boxShadow,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CardStyle) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      fontSize.hashCode ^
      fontStyle.hashCode ^
      fontWeight.hashCode ^
      textAlign.hashCode ^
      textColor.hashCode ^
      borderStyle.hashCode ^
      borderColor.hashCode ^
      borderWidth.hashCode ^
      borderRadius.hashCode ^
      padding.hashCode ^
      margin.hashCode ^
      orientation.hashCode ^
      alignment.hashCode ^
      boxShadow.hashCode ^
      primaryColor.hashCode ^
      secondaryColor.hashCode;
}
