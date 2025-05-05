import 'package:flutter/material.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CardTypeSelector extends StatefulWidget {
  final CardType selectedCardType;
  final ValueChanged<CardType> onChanged;
  final Color? color;

  const CardTypeSelector({
    super.key,
    required this.selectedCardType,
    required this.onChanged,
    this.color,
  });

  @override
  _CardTypeSelectorState createState() => _CardTypeSelectorState();
}

class _CardTypeSelectorState extends State<CardTypeSelector> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: CardType.values.map((cardType) {
          return Row(
            children: [
              Radio<CardType>(
                activeColor: widget.color,
                value: cardType,
                groupValue: widget.selectedCardType,
                onChanged: (CardType? value) {
                  if (value != null) {
                    widget.onChanged(value);
                  }
                },
              ),
              Text(
                cardType.name[0].toUpperCase() +
                    cardType.name.substring(1), // Capitalize
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
