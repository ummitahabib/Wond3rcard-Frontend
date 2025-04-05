import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_type.dart';
import 'package:wond3rcard/src/cards/views/widgets/layout_selection.dart';
import 'package:wond3rcard/src/cards/views/widgets/reusable_card_text.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/ui_data.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class CardLayout3 extends StatefulHookConsumerWidget {
  final Function(String) onLayoutSelected;

  const CardLayout3({super.key, required this.onLayoutSelected});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardLayout3State();
}

class _CardLayout3State extends ConsumerState<CardLayout3> {
  @override
  Widget build(BuildContext context) {
    void showLayoutSelection(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return LayoutSelection(
            selectedLayout: "Layout 3",
            onLayoutSelected: (String newLayout) {
              widget.onLayoutSelected(newLayout);
            },
          );
        },
      );
    }

    final cardColor = ref.watch(cardProvider);
    CardType selectedCardType = CardType.personal;

    return Scaffold(
      backgroundColor: AppColors.redDisable,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableCardText(),
              const SizedBox(height: 10),
              Stack(
                children: [
                  _buildCardContainer(cardColor.selectedColor),
                  Positioned(left: 25, top: 159, child: userProfileImage()),
                ],
              ),
              const SizedBox(height: 50),
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
              _buildColorSelector(cardColor),
              const SizedBox(height: 20),
              reusableCardText(text: 'Select type of card'),
              const SizedBox(height: 10),
              CardTypeSelector(
                color: cardColor.selectedColor,
                selectedCardType: selectedCardType,
                onChanged: (CardType newType) {
                  setState(() {
                    selectedCardType = newType;
                  });
                },
              ),
              const SizedBox(height: 15),
              _buildBottomButtons(cardColor.selectedColor),
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
      child: const Center(
        child: Text(
          "Your Card",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildColorSelector(CardNotifier cardColor) {
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
              onTap: () => setState(() => cardColor.selectedColor = color),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 34.14,
                height: 34.14,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: cardColor.selectedColor == color ? 6 : 0,
                      color: cardColor.selectedColor == color
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
              
              trailingIcon: const HeroIcon(HeroIcons.backward,
                  color: AppColors.defaultWhite, size: 16),
              text: '',
              onPressed: () {}),
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
              trailingIcon: const HeroIcon(HeroIcons.forward,
                  color: AppColors.defaultWhite, size: 16),
              onPressed: () {}),
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
