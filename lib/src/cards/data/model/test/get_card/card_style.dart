import 'dart:convert';

import 'package:hive/hive.dart';

part 'card_style.g.dart';
@HiveType(typeId: 0)
class CardStyle extends HiveObject {
  @HiveField(0)
  String? fontSize;
  @HiveField(1)
  String? fontStyle;
  @HiveField(2)
  String? fontWeight;
  @HiveField(3)
  String? textAlign;
  @HiveField(4)
  String? textColor;
  @HiveField(5)
  String? borderStyle;
  @HiveField(6)
  String? borderColor;
  @HiveField(7)
  String? borderWidth;
  @HiveField(8)
  String? borderRadius;
  @HiveField(9)
  String? padding;
  @HiveField(10)
  String? margin;
  @HiveField(11)
  String? orientation;
  @HiveField(12)
  String? alignment;
  @HiveField(13)
  String? boxShadow;
  @HiveField(14)
  String? primaryColor;
  @HiveField(15)
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

  Map<String, dynamic> toMap() {
    return {
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
  }

  factory CardStyle.fromMap(Map<String, dynamic> map) {
    return CardStyle(
      fontSize: map['fontSize'],
      fontStyle: map['fontStyle'],
      fontWeight: map['fontWeight'],
      textAlign: map['textAlign'],
      textColor: map['textColor'],
      borderStyle: map['borderStyle'],
      borderColor: map['borderColor'],
      borderWidth: map['borderWidth'],
      borderRadius: map['borderRadius'],
      padding: map['padding'],
      margin: map['margin'],
      orientation: map['orientation'],
      alignment: map['alignment'],
      boxShadow: map['boxShadow'],
      primaryColor: map['primaryColor'],
      secondaryColor: map['secondaryColor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CardStyle.fromJson(String source) => CardStyle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardStyle(fontSize: $fontSize, fontStyle: $fontStyle, fontWeight: $fontWeight, textAlign: $textAlign, textColor: $textColor, borderStyle: $borderStyle, borderColor: $borderColor, borderWidth: $borderWidth, borderRadius: $borderRadius, padding: $padding, margin: $margin, orientation: $orientation, alignment: $alignment, boxShadow: $boxShadow, primaryColor: $primaryColor, secondaryColor: $secondaryColor)';
  }

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
    return fontSize == other.fontSize &&
        fontStyle == other.fontStyle &&
        fontWeight == other.fontWeight &&
        textAlign == other.textAlign &&
        textColor == other.textColor &&
        borderStyle == other.borderStyle &&
        borderColor == other.borderColor &&
        borderWidth == other.borderWidth &&
        borderRadius == other.borderRadius &&
        padding == other.padding &&
        margin == other.margin &&
        orientation == other.orientation &&
        alignment == other.alignment &&
        boxShadow == other.boxShadow &&
        primaryColor == other.primaryColor &&
        secondaryColor == other.secondaryColor;
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
