import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/social_media/data/controller/social_media_controller.dart';
import 'package:wond3rcard/src/admin/social_media/data/model/social_media.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_social_links.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_type.dart';
import 'package:wond3rcard/src/cards/views/widgets/close_review_button.dart';
import 'package:wond3rcard/src/onboarding/data/controller/onboarding_controller.dart';
import 'package:wond3rcard/src/onboarding/views/pages/mobile/onboarding_fifth_screen_mobile.dart';
import 'package:wond3rcard/src/onboarding/views/pages/mobile/onboarding_fourth_screen_mobile.dart';
import 'package:wond3rcard/src/shared/views/widgets/custom_app_bar.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/add_and_save_account.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/back_navigator.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/file_upload.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class CreateNewCard extends StatefulHookConsumerWidget {
  const CreateNewCard({super.key});
  final String routeName = RouteString.createNewCard;

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
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: HeroIcon(HeroIcons.arrowLeft),
        ),
        title: Text('Create Card - Step 1'),
        
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              
              width: 90,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.defaultWhite,
            
              borderRadius: BorderRadius.circular(8)
            ),
            child: Center(child: Text('Save', style: WonderCardTypography.boldTextTitle2(fontSize: 16, color: AppColors.grayScale))),
            
            ),
          )
        ],),
    
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
              WonderCardButton(
                showLoader: cardController.loading,
                text: 'Save and Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateNewCardStepTwo(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      appBar: CustomAppBar(
          leading:  BackNavigator(
             onPress: () => context.go('/'),
          ), title: 'Create Card - Step 2'),
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
              WonderCardButton(
                showLoader: cardController.loading,
                text: 'Save and Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateNewCardStepThree(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      appBar: CustomAppBar(
          leading:  BackNavigator(
             onPress: () => context.go('/'),
          ), title: 'Create Card - Step 2'),
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
              WonderCardButton(
                showLoader: cardController.loading,
                text: 'Save and Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateNewCardStepFour(),
                    ),
                  );
                },
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

//   uploadPhotoMethod(onboardingController),
class CreateNewCardStepFour extends HookConsumerWidget {
  const CreateNewCardStepFour({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingController = ref.watch(onboardingProvider);
    final cardController = ref.watch(cardProvider);

    return Scaffold(
      appBar: CustomAppBar(
          leading:  BackNavigator(
             onPress: () => context.go('/'),
          ), title: 'Create Card - Step 4'),
      backgroundColor: AppColors.defaultWhite,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            uploadPhotoMethod(cardController: cardController),
            WonderCardButton(
              showLoader: cardController.loading,
              text: 'Continue',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateNewCardStep5(),
                  ),
                );
              },
              // onPressed: () async {
              //   try {
              //     await ref.watch(cardProvider).createCard(context);
              //   } catch (e) {
              //     print('Error: $e');
              //   }
              // },
            ),
          ],
        ),
      ),
    );
  }
}

class CreateNewCardStep5 extends HookConsumerWidget {
  const CreateNewCardStep5({super.key});

  static const routeName = RouteString.createNewCardStep5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final onboardingController = ref.watch(onboardingProvider);
    final cardController = ref.watch(cardProvider);

    final socialController = ref.watch(socialProvider);

    useEffect(
      () {
        Future.delayed(Duration.zero, () async {
          try {
            await ref.read(socialProvider).getSocialMedia(context);
          } catch (error) {}
        });
        return null;
      },
      [],
    );

    return Scaffold(
      appBar: CustomAppBar(leading:  BackNavigator(
         onPress: () => context.go('/'),
      ), title: ''),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SocialMediaSwitches(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Social Media',
                    style: WonderCardTypography.boldTextTitle2(
                      fontSize: SpacingConstants.size16,
                      color: AppColors.grayScale,
                    ),
                  ),
                  Text(
                    viewAllText,
                    style: WonderCardTypography.boldTextTitle2(
                      fontSize: SpacingConstants.size16,
                      color: AppColors.grayScale300,
                    ),
                  ),
                ],
              ),
            ),
            socialController.loading
                ? const Center(child: CircularProgressIndicator())
                : socialController.socialMedias.isEmpty
                    ? const Center(child: Text('No social media links found.'))
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        child:
                            SocialMediaList(socialController: socialController),
                      ),
            WonderCardButton(
              showLoader: cardController.loading,
              text: 'Submit',
              onPressed: () async {
                try {
                  await ref.watch(cardProvider).createCard(context);
                } catch (e) {
                  print('Error: $e');
                }
              },
            ),
          ],
        ),
      ),
    );

    // Column(
    //   children: [
    //     const SocialMediaSwitches(),
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
    //   ],
    // );
  }
}

GestureDetector uploadPhotoMethod({
  required CardNotifier cardController,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap ??
        () async {
          final File? pickedFile = await FileUploadUtility.pickImage();
          if (pickedFile != null) {
            cardController.setUploadedImage(pickedFile);
          }
        },
    child: Center(
      child: cardController.uploadedImage != null
          ? SizedBox(
              width: SpacingConstants.size200,
              height: SpacingConstants.size200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SpacingConstants.size100),
                child: Image.file(
                  cardController.uploadedImage!,
                  width: SpacingConstants.size250,
                  height: SpacingConstants.size200,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Image.asset(
              ImageAssets.profileImage,
              width: SpacingConstants.size250,
              height: SpacingConstants.size200,
            ),
    ),
  );
}
