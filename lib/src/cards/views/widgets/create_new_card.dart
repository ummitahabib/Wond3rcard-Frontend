import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/address_field.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class CreateNewCard extends StatefulHookConsumerWidget {
  const CreateNewCard({super.key});
  final String routeName = RouteString.createNewCard;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateNewCardState();
}

class _CreateNewCardState extends ConsumerState<CreateNewCard> {
  late TextEditingController dobController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dobController = TextEditingController();
  }

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _saveAndContinue(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      // All required fields are valid
      context.go(RouteString.createNewCardTwo);
    } else {
      // Show error message if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

       useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final cardController = ref.read(cardProvider);
          final profileController = ref.watch(profileProvider);
          if (cardController.getCardsResponse == null) {
            Future.delayed(Duration.zero, () async {
                await ref.read(cardProvider).getAUsersCard(context, 
                                    '',);
              await profileController.getProfile(context);
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
        route: RouteString.mainDashboard,
      ),
      backgroundColor: AppColors.defaultWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: SpacingConstants.size20, horizontal: 25),
          child: isMobile(context)
              ? _createCardForm(cardController, context)
              : Center(
                child: Container(
                  
                  width: MediaQuery.of(context).size.width / 4,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    child: _createCardForm(cardController, context)),
              ),
        ),
      ),
    );
  }

  Form _createCardForm(CardNotifier cardController, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Personal Details',
            style: WonderCardTypography.boldTextTitleBold(),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: 'Enter your firstname',
            text: 'First name',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.firstName,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First name is required';
              }
              return null;
            },
          ),
          CustomTextField(
            hintText: 'Enter your lastname',
            text: 'Last name',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.lastName,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last name is required';
              }
              return null;
            },
          ),
          CustomTextField(
            hintText: 'Enter your othername',
            text: 'Other name',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.middleName,
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: CustomTextField(
                hintText: 'Select your date of birth',
                text: 'DOB',
                fillColor: AppColors.defaultWhite,
                textEditingController: dobController,
                isRequired: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date of birth is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          CustomTextField(
            hintText: "e.g., Mr., Mrs., Eng.",
            text: 'Suffix',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.suffix,
          ),
          const SizedBox(height: 15),
          AddressField(),
          const SizedBox(height: 15),
          Center(
            child: WonderCardButton(
              textColor: Colors.white,
              showLoader: cardController.loading,
              text: 'Save and Continue',
              onPressed: () => _saveAndContinue(context),
            ),
          ),
        ],
      ),
    );
  }
}
