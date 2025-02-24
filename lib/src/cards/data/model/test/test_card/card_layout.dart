class CardLayout {
  String? padding;
  String? margin;
  String? layoutOrientation;

  CardLayout({this.padding, this.margin, this.layoutOrientation});

  factory CardLayout.fromJson(Map<String, dynamic> json) => CardLayout(
        padding: json['padding'] as String?,
        margin: json['margin'] as String?,
        layoutOrientation: json['layoutOrientation'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'padding': padding,
        'margin': margin,
        'layoutOrientation': layoutOrientation,
      };
}
