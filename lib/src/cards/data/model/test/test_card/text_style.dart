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

  factory TextStyle.fromJson(Map<String, dynamic> json) => TextStyle(
        fontSize: json['fontSize'] as String?,
        fontStyle: json['fontStyle'] as String?,
        fontWeight: json['fontWeight'] as String?,
        textAlign: json['textAlign'] as String?,
        textColor: json['textColor'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'fontSize': fontSize,
        'fontStyle': fontStyle,
        'fontWeight': fontWeight,
        'textAlign': textAlign,
        'textColor': textColor,
      };
}
