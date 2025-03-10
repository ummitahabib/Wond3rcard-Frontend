import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_new_card_step_two.dart';
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

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
              CustomTextField(
                hintText: 'Enter your lastname',
                text: 'Last name',
                fillColor: AppColors.defaultWhite,
                textEditingController: cardController.lastName,
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
                  showLoader: cardController.loading,
                  text: 'Save and Continue',
                  onPressed: () {
                    context.go(RouteString.createNewCardTwo);
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
