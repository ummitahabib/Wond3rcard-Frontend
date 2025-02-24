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

  factory CardDesign.fromJson(Map<String, dynamic> json) => CardDesign(
        backgroundColor: json['backgroundColor'] as String?,
        backgroundImage: json['backgroundImage'] as String?,
        borderStyle: json['borderStyle'] as String?,
        borderColor: json['borderColor'] as String?,
        borderWidth: json['borderWidth'] as String?,
        borderRadius: json['borderRadius'] as String?,
        boxShadow: json['boxShadow'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'backgroundColor': backgroundColor,
        'backgroundImage': backgroundImage,
        'borderStyle': borderStyle,
        'borderColor': borderColor,
        'borderWidth': borderWidth,
        'borderRadius': borderRadius,
        'boxShadow': boxShadow,
      };
}
