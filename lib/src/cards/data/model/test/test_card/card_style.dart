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

  factory CardStyle.fromJson(Map<String, dynamic> json) => CardStyle(
        fontSize: json['fontSize'] as String?,
        fontStyle: json['fontStyle'] as String?,
        fontWeight: json['fontWeight'] as String?,
        textAlign: json['textAlign'] as String?,
        textColor: json['textColor'] as String?,
        borderStyle: json['borderStyle'] as String?,
        borderColor: json['borderColor'] as String?,
        borderWidth: json['borderWidth'] as String?,
        borderRadius: json['borderRadius'] as String?,
        padding: json['padding'] as String?,
        margin: json['margin'] as String?,
        orientation: json['orientation'] as String?,
        alignment: json['alignment'] as String?,
        boxShadow: json['boxShadow'] as String?,
        primaryColor: json['primaryColor'] as String?,
        secondaryColor: json['secondaryColor'] as String?,
      );

  Map<String, dynamic> toJson() => {
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
