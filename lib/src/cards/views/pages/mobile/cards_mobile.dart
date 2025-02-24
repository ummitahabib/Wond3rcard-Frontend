import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_widgets.dart';
import 'package:wond3rcard/src/shared/views/widgets/custom_app_bar.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class CardsMobile extends HookConsumerWidget {
  const CardsMobile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.read(cardProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final cardController = ref.read(cardProvider);
          // if (cardController.cards.isEmpty) {
          Future.delayed(Duration.zero, () async {
            await cardController.getAllUsersCard();
          });
          // }
        });
        return null;
      },
      [],
    );

    return Scaffold(
      appBar: CustomAppBar(
        leading: SizedBox(),
        title: 'My Cards',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                context.go(RouteString.createNewCard);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryShade,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const HeroIcon(
                  HeroIcons.plus,
                  color: AppColors.defaultWhite,
                ),
              ),
            ),
          )
        ],
      ),
      body: cardController.loading
          ? const Center(child: CircularProgressIndicator())
          :  (!cardController.loading && cardController.getCardsResponse == null)
          ? GestureDetector(
                  onTap: () {},
                  child: CardListWidget(
                    cardController: cardController,
                  ),
                )
    
              : const NoCardsWidget()
    );
  }
}

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
