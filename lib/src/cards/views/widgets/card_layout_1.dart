import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_type.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_new_card_step_four.dart';
import 'package:wond3rcard/src/cards/views/widgets/font_widget.dart';
import 'package:wond3rcard/src/cards/views/widgets/layout_selection.dart';
import 'package:wond3rcard/src/cards/views/widgets/reusable_card_text.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/ui_data.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class CardLayout1 extends StatefulHookConsumerWidget {
  final Function(String) onLayoutSelected;

  const CardLayout1({super.key, required this.onLayoutSelected});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardLayout1State();
}

class _CardLayout1State extends ConsumerState<CardLayout1> {
  @override
  Widget build(BuildContext context) {
    void showLayoutSelection(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return LayoutSelection(
            selectedLayout: "Layout 1",
            onLayoutSelected: (String newLayout) {
              widget.onLayoutSelected(newLayout);
            },
          );
        },
      );
    }

    void showFontSelection(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return FontCustomizationCard();
        },
      );
    }

    final cardController = ref.watch(cardProvider);
    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableCardText(),
              Stack(
                children: [
                  _buildCardContainer(cardController.selectedColor),
                  Positioned(
                    left: 25,
                    top: 159,
                    child: uploadPhotoMethod(context: context, ref: ref)
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                     width: 346,
                child: WonderCardButton(
                           
                  variant: ButtonVariant.outline,
                  text: 'Select Card Font',
                  onPressed: () => showFontSelection(context),
                  backgroundColor: AppColors.transparent,
                  borderColor: AppColors.grayScale,
                ),
              ),
              SizedBox(
                  width: 346,
                child: WonderCardButton(
                
                  variant: ButtonVariant.outline,
                  text: 'Change Card Layout',
                  onPressed: () => showLayoutSelection(context),
                  backgroundColor: AppColors.transparent,
                  borderColor: AppColors.grayScale,
                ),
              ),
              const SizedBox(height: 30),
              Text('Card color',
                  style: WonderCardTypography.boldTextTitleBold(
                      color: AppColors.grayScale, fontSize: 18)),
              _buildColorSelector(cardController),
              const SizedBox(height: 20),
              reusableCardText(text: 'Select type of card'),
              CardTypeSelector(
                color: cardController.selectedColor,
                selectedCardType: cardController.selectedCardType,
                onChanged: (CardType newType) {
                  setState(() {
                    cardController.selectedCardType = newType;
                    cardController.cardType.text = newType.name;
                    print(
                        'Selected Card Type: ${cardController.selectedCardType}');
                  });
                },
              ),
              const SizedBox(height: 15),
              _buildBottomButtons(cardController.selectedColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContainer(Color color) {
    return Container(
      width: 346,
      height: 197,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 10)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  width: 33,
                  height: 33,
                  decoration: BoxDecoration(
                    color: AppColors.defaultWhite,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: HeroIcon(
                      HeroIcons.camera,
                      color: AppColors.grayScale600,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColorSelector(CardNotifier cardController) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 59,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(0, 0))
          ],
          color: AppColors.defaultWhite,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: predefinedColors.map((color) {
            return GestureDetector(
              onTap: () => setState(() => cardController.selectedColor = color),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 34.14,
                height: 34.14,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: cardController.selectedColor == color ? 6 : 0,
                      color: cardController.selectedColor == color
                          ? AppColors.grayScale600
                          : AppColors.transparent),
                  color: color,
                  borderRadius: BorderRadius.circular(426.75),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
           width: 65,
          child: WonderCardButton(
              backgroundColor: color,
             
              trailingIcon: const HeroIcon(HeroIcons.arrowLeft,
                  color: AppColors.defaultWhite, size: 16),
              text: '',
              onPressed: () {
                context.go(RouteString.mainDashboard);
              }),
        ),
        SizedBox(
           width: 136,
          child: WonderCardButton(
              backgroundColor: color,
              textColor: AppColors.defaultWhite,
             
              text: 'Preview',
              onPressed: () {}),
        ),
        SizedBox(
            width: 136,
          child: WonderCardButton(
              backgroundColor: color,
              textColor: AppColors.defaultWhite,
            
              text: 'Next',
              trailingIcon: const HeroIcon(HeroIcons.arrowRight,
                  color: AppColors.defaultWhite, size: 16),
              onPressed: () {
                context.go(RouteString.createNewCard);
              }),
        ),
      ],
    );
  }
}

void saveColorPreference(Color color) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('selectedColor', color.value);
}

Future<Color> loadColorPreference() async {
  final prefs = await SharedPreferences.getInstance();
  return Color(prefs.getInt('selectedColor') ?? Colors.blue.value);
}
