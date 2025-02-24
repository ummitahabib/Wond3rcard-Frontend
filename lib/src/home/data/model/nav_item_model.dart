import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class NavItemModel {
  final HeroIcons icon;
  final String label;
  final Color activeColor;
  final Color inactiveColor;

  NavItemModel({
    required this.icon,
    required this.label,
    required this.activeColor,
    required this.inactiveColor,
  });
}
