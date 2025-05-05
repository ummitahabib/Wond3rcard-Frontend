import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_widgets.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

Container selectAddress() {
  return Container(
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const HeroIcon(HeroIcons.xMark, size: 28),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Select Adress Lebel',
              style: WonderCardTypography.boldTextTitleBold(
                color: AppColors.grayScale,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        cardRow(
          text: 'Home',
          onTap: () {},
        ),
        cardRow(
          text: 'Office',
          onTap: () {},
        ),
        cardRow(
          text: 'Branch',
          onTap: () {},
        ),
        cardRow(
          text: 'Others',
          onTap: () {},
        ),
      ],
    ),
  );
}
