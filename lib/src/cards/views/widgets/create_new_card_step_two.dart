import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/close_review_button.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class CreateNewCardStepTwo extends StatefulHookConsumerWidget {
  const CreateNewCardStepTwo({super.key});
  final String routeName = RouteString.createNewCardTwo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewCardStepTwoState();
}

class _CreateNewCardStepTwoState extends ConsumerState<CreateNewCardStepTwo> {
  late CardNotifier cardController;

  @override
  void initState() {
    super.initState();
    cardController = ref.read(cardProvider);
    cardController.cardType.text = cardController.selectedCardType.name;
  }

  @override
  void dispose() {
    cardController.cardTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardController = ref.watch(cardProvider);

    return Scaffold(
      appBar: CreateCardReusableAppBar(
        route: RouteString.createNewCard,
        titleText: 'Step 2 of 4',
      ),
      backgroundColor: AppColors.defaultWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: SpacingConstants.size20, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  inputType: TextInputType.phone,
                  textEditingController: cardController.contactInfoPhone,
                  isRequired: true,
                  hintColor: AppColors.lighDisable,
                  textColor: AppColors.grayScale600,
                  fillColor: AppColors.defaultWhite,
                  hintText: '+234 123 456 78',
                  text: enterPhoneNumber,
                  type: TextFieldType.Number),
              CustomTextField(
                hintText: 'Selected Card Type',
                text: 'Card Type',
                fillColor: AppColors.defaultWhite,
                textEditingController: cardController.cardType,
              ),
              CustomTextField(
                hintText: 'Enter website',
                text: 'Websites',
                fillColor: AppColors.defaultWhite,
                textEditingController: cardController.contactInfoWebsite,
              ),
              CustomAddress(
                addressText: 'Home Address',
                textEditingController: cardController.contactInfoAddress,
              ),
              CustomTextField(
                hintText: 'Enter card name',
                text: 'Card name',
                fillColor: AppColors.defaultWhite,
                textEditingController: cardController.cardName,
              ),
              const SizedBox(height: 15),
              Center(
                child: WonderCardButton(
                  showLoader: cardController.loading,
                  text: 'Save and Continue',
                  onPressed: () {
                    context.go(RouteString.createNewCardThree);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
