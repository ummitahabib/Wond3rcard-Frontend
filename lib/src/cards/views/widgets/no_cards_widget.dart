import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class NoCardsWidget extends StatelessWidget {
  const NoCardsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(ImageAssets.emptyCard)),
          const SizedBox(
            height: 15,
          ),
          Text(
            'No active card',
            style: WonderCardTypography.boldTextTitleBold(),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Please add some card to your card',
            style: WonderCardTypography.boldTextTitleBold(),
          ),
          const SizedBox(
            height: 10,
          ),
          WonderCardButton(
              textColor: AppColors.defaultWhite,
              buttonWidth: 290,
              trailingIcon: const HeroIcon(
                HeroIcons.plus,
                color: AppColors.defaultWhite,
              ),
              backgroundColor: AppColors.primaryShade,
              borderColor: AppColors.primaryShade,
              borderRadius: BorderRadius.circular(27.5),
              text: 'Create New Card',
              onPressed: () {
                context.go(RouteString.createNewCard);
              },
              )
        ],
      ),
    );
  }
}
