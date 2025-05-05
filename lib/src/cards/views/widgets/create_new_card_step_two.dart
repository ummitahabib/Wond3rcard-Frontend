import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
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
          child:  isDesktop(context) ?
           Center(
                child: Container(
                  
                  width: MediaQuery.of(context).size.width / 4,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    child: _createCardStep2Textfield(cardController, context)),
              ): 
          
          _createCardStep2Textfield(cardController, context),
        ),
      ),
    );
  }

  Column _createCardStep2Textfield(CardNotifier cardController, BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              inputType: TextInputType.phone,
              textEditingController: cardController.contactInfoPhone,
              isRequired: true,
              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              final phonePattern = r'^\d{3} \d{3} \d{2}$';
              final phoneRegExp = RegExp(phonePattern);
              if (!phoneRegExp.hasMatch(value)) {
                return 'Please enter a valid phone number (e.g., 123 456 78)';
              }
              return null;
              },
              hintColor: AppColors.lighDisable,
              textColor: AppColors.grayScale600,
              fillColor: AppColors.defaultWhite,
              hintText: ' 123 456 78',
              text: enterPhoneNumber,
              type: TextFieldType.Number),
            DropdownButtonFormField<String>(
            value: cardController.selectedCardType.name.isNotEmpty &&
                ['Personal', 'Teams', 'Organization']
                  .contains(cardController.selectedCardType.name)
              ? cardController.selectedCardType.name
              : 'Personal',
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.defaultWhite,
              labelText: 'Card Type',
              labelStyle: TextStyle(color: AppColors.grayScale600),
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grayScale50),
              ),
            ),
            items: ['Personal', 'Teams', 'Organization']
              .map((type) => DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                ))
              .toList(),
            onChanged: (value) {
              if (value != null) {
              setState(() {
                cardController.cardTypeController.text = value;
              });
              }
            },
            ),
            SizedBox(height: 5),
            CustomTextField(
            hintText: 'Enter website (e.g., https://example.com)',
            text: 'Websites',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.contactInfoWebsite,
            inputType: TextInputType.url,
            validator: (value) {
              if (value == null || value.isEmpty) {
              return 'Please enter a website link';
              }
              final urlPattern =
                r'^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-]*)*\/?$';
              final urlRegExp = RegExp(urlPattern);
              if (!urlRegExp.hasMatch(value)) {
              return 'Please enter a valid website link';
              }
              return null;
            },
            ),
            CustomTextField(
            hintText: 'Enter card name',
            text: 'Card name',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.cardName,
            required: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
              return 'Card name is required';
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
              if (cardController.contactInfoPhone.text.isEmpty ||
                cardController.cardName.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please fill all required fields'),
                  backgroundColor: Colors.red,
                ),
                );
                return;
              }
              context.go(RouteString.createNewCardThree);
              },
            ),
            ),
          ],
          
        );
  }
}
