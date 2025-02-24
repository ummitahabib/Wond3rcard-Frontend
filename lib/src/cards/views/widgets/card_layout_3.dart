import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_type.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/ui_data.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class CardLayout3 extends StatefulHookConsumerWidget {
  const CardLayout3({super.key});

  final String routeName = RouteString.colorPallete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardLayout3State();
}

class _CardLayout3State extends ConsumerState<CardLayout3> {
  @override
  Widget build(BuildContext context) {
    final cardColor = ref.watch(cardProvider);
    CardType selectedCardType = CardType.personal;

    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableCardText(),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Container(
                    width: 346,
                    height: 197,
                    decoration: BoxDecoration(
                      color: cardColor.selectedColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Your Card",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 25,
                    top: 159,
                    child: userProfileImage(),
                  )
                ],
              ),

              const SizedBox(height: 50),

              WonderCardButton(
                buttonWidth: 346,
                variant: ButtonVariant.outline,
                text: 'Change Card Layout',
                onPressed: () {
                  context.go(RouteString.cardLayout);
                },
                backgroundColor: AppColors.transparent,
                borderColor: AppColors.grayScale,
              ),

              const SizedBox(height: 30),

              // Predefined Colors Title
              Text("Card color",
                  style: WonderCardTypography.boldTextTitleBold(fontSize: 18)),
              const SizedBox(height: 15),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 59,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      color: AppColors.defaultWhite,
                      borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    children: predefinedColors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            cardColor.selectedColor = color;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5), // Adjust spacing between items
                          width: 34.14,
                          height: 34.14,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: cardColor.selectedColor == color ? 6 : 0,
                              color: cardColor.selectedColor == color
                                  ? AppColors.grayScale600
                                  : AppColors.transparent,
                            ),
                            color: color,
                            borderRadius: BorderRadius.circular(426.75),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              reusableCardText(
                text: 'Select type of card',
              ),

              const SizedBox(
                height: 10,
              ),

              CardTypeSelector(
                color: cardColor.selectedColor,
                selectedCardType: selectedCardType,
                onChanged: (CardType newType) {
                  setState(() {
                    selectedCardType = newType;
                  });
                },
              ),

              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WonderCardButton(
                    backgroundColor: cardColor.selectedColor,
                    buttonWidth: 65,
                    trailingIcon: const HeroIcon(
                      HeroIcons.backward,
                      color: AppColors.defaultWhite,
                      size: 16,
                    ),
                    text: '',
                    onPressed: () {},
                  ),
                  WonderCardButton(
                    backgroundColor: cardColor.selectedColor,
                    textColor: AppColors.defaultWhite,
                    buttonWidth: 136,
                    text: 'Preview',
                    onPressed: () {},
                  ),
                  WonderCardButton(
                    backgroundColor: cardColor.selectedColor,
                    textColor: AppColors.defaultWhite,
                    buttonWidth: 136,
                    text: 'Next',
                    trailingIcon: const HeroIcon(
                      HeroIcons.forward,
                      color: AppColors.defaultWhite,
                      size: 16,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Text reusableCardText({double? fontSize, String? text}) {
    return Text(
      textAlign: TextAlign.left,
      text ?? 'Image & Layout',
      style: WonderCardTypography.boldTextTitleBold(
          color: AppColors.grayScale, fontSize: fontSize ?? 18),
    );
  }

  void showColorPicker(
    BuildContext context,
    CardNotifier cardColor,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = cardColor.selectedColor;
        return AlertDialog(
          title: const Text("Pick a Color"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: cardColor.selectedColor,
              onColorChanged: (color) {
                tempColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  cardColor.selectedColor = tempColor; // Update selected color
                });
                Navigator.of(context).pop();
              },
              child: const Text("Select"),
            ),
          ],
        );
      },
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
