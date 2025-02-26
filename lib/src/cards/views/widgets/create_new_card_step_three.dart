
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_new_card_step_four.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';



class CreateNewCardStepThree extends StatefulHookConsumerWidget {
  const CreateNewCardStepThree({super.key});
  final String routeName = RouteString.createNewCardTwo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewCardStepThreeState();
}

class _CreateNewCardStepThreeState
    extends ConsumerState<CreateNewCardStepThree> {
  late TextEditingController cardTypeController;
  CardType selectedCardType = CardType.personal;

  @override
  void initState() {
    super.initState();
    cardTypeController = TextEditingController(text: selectedCardType.name);
  }

  @override
  void dispose() {
    cardTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardController = ref.watch(cardProvider);

    return Scaffold(
      appBar: CreateCardReusableAppBar(
        route: RouteString.createNewCardTwo,
        titleText: 'Step 3 of 5',
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
                hintText: 'Enter website',
                text: 'Websites',
                fillColor: AppColors.defaultWhite,
                textEditingController: cardController.contactInfoWebsite,
              ),
              CustomTextField(
                hintText: 'Enter work email',
                text: 'Work Email',
                fillColor: AppColors.defaultWhite,
                textEditingController: cardController.contactInfoEmail,
              ),
              CustomTextField(
                hintText: 'Enter job title',
                text: 'Job title',
                fillColor: AppColors.defaultWhite,
                textEditingController: cardController.position,
              ),
              CustomTextField(
                hintText: 'Enter notes',
                text: 'Notes',
                fillColor: AppColors.defaultWhite,
                textEditingController: cardController.notes,
              ),
              CustomTextField(
                hintText: 'Enter video url',
                text: 'Video url',
                fillColor: AppColors.defaultWhite,
                textEditingController: cardController.videoUrl,
              ),
              const SizedBox(height: 15),
              Center(
                child: WonderCardButton(
                  showLoader: cardController.loading,
                  text: 'Save and Continue',
                  onPressed: () {
                    context.go(RouteString.createNewCardFour);
                  },
                ),
              ),

              // WonderCardButton(
              //   showLoader: cardController.loading,
              //   text: 'Submit',
              //   onPressed: () async {
              //     try {
              //       await ref.watch(cardProvider).createCard(context);
              //     } catch (e) {
              //       print('Error: $e');
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
