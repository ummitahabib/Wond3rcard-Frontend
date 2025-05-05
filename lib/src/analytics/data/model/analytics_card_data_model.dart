import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CardDataModel {
  final String title;
  final HeroIcons icon;
  final Color iconColor;

  CardDataModel({
    required this.title,
    required this.icon,
    required this.iconColor,
  });
}
