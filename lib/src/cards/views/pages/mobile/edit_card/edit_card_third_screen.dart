import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class EditCardThirdScreen extends StatefulHookConsumerWidget {
  const EditCardThirdScreen({super.key, required this.cardId});
  final String cardId;

  final String routeName = RouteString.createNewCardThree;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCardThirdScreenState();
}

class _EditCardThirdScreenState extends ConsumerState<EditCardThirdScreen> {
  late CardNotifier cardController;

  @override
  void initState() {
    super.initState();
    cardController = ref.read(cardProvider);

    final cardModel = cardController.cardModel;

    if (cardModel != null) {
      cardController.contactInfoEmail.text = cardModel.email ?? '';
      cardController.position.text = cardModel.designation ?? '';
      cardController.notes.text = cardModel.notes ?? '';
      // cardController.videoUrl.text = cardModel.cardVideo ?? '';
    } else {
      cardController.clearStep3Fields();
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final cardController = ref.read(cardProvider);
          if (cardController.getCardsResponse == null) {
            Future.delayed(Duration.zero, () async {
              await ref.read(cardProvider).getAUsersCard(
                    context,
                    widget.cardId,
                  );
            });
          }
        });
        return null;
      },
      [],
    );
    final cardController = ref.watch(cardProvider);

    return Scaffold(
      appBar: CreateCardReusableAppBar(
        route: RouteString.createNewCardTwo,
        titleText: 'Step 3 of 4',
      ),
      backgroundColor: AppColors.defaultWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: SpacingConstants.size20, horizontal: 25),
          child: isDesktop(context)
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    child: step3Form(cardController, context),
                  ),
                )
              : step3Form(cardController, context),
        ),
      ),
    );
  }

  Form step3Form(CardNotifier cardController, BuildContext context) {
    return Form(
      key: cardController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            hintText: 'Enter work email',
            text: 'Work Email',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.contactInfoEmail,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Work email is required';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          CustomTextField(
            hintText: 'Enter job title',
            text: 'Job Title',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.position,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Job title is required';
              }
              return null;
            },
          ),
          CustomTextField(
            hintText: 'Enter notes',
            text: 'Notes',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.notes,
            isRequired: false,
            maxLines: 4,
          ),
          CustomTextField(
            hintText: 'Enter video URL (e.g., https://example.com)',
            text: 'Video URL',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.videoUrl,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Video URL is required';
              }
              final uri = Uri.tryParse(value);
              if (uri == null || !uri.isAbsolute) {
                return 'Enter a valid URL';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          Center(
            child: WonderCardButton(
              textColor: AppColors.defaultWhite,
              showLoader: cardController.loading,
              text: 'Save and Continue',
              onPressed: () {
                if (cardController.formKey.currentState?.validate() ?? false) {
                  context.go(RouteString.createNewCardFour);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all required fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
