import 'dart:convert';

import 'package:collection/collection.dart';

class TextStyle {
  String? fontSize;
  String? fontStyle;
  String? fontWeight;
  String? textAlign;
  String? textColor;

  TextStyle({
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.textAlign,
    this.textColor,
  });

  @override
  String toString() {
    return 'TextStyle(fontSize: $fontSize, fontStyle: $fontStyle, fontWeight: $fontWeight, textAlign: $textAlign, textColor: $textColor)';
  }

  factory TextStyle.fromMap(Map<String, dynamic> data) => TextStyle(
        fontSize: data['fontSize'] as String?,
        fontStyle: data['fontStyle'] as String?,
        fontWeight: data['fontWeight'] as String?,
        textAlign: data['textAlign'] as String?,
        textColor: data['textColor'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'fontSize': fontSize,
        'fontStyle': fontStyle,
        'fontWeight': fontWeight,
        'textAlign': textAlign,
        'textColor': textColor,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TextStyle].
  factory TextStyle.fromJson(String data) {
    return TextStyle.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TextStyle] to a JSON string.
  String toJson() => json.encode(toMap());

  TextStyle copyWith({
    String? fontSize,
    String? fontStyle,
    String? fontWeight,
    String? textAlign,
    String? textColor,
  }) {
    return TextStyle(
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
      fontWeight: fontWeight ?? this.fontWeight,
      textAlign: textAlign ?? this.textAlign,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TextStyle) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      fontSize.hashCode ^
      fontStyle.hashCode ^
      fontWeight.hashCode ^
      textAlign.hashCode ^
      textColor.hashCode;
}
