import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/file_upload.dart';
import 'package:wond3rcard/src/utils/util.dart';


class CreateNewCardStepFour extends HookConsumerWidget {
  const CreateNewCardStepFour({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.watch(cardProvider);
    return Scaffold(
       appBar: CreateCardReusableAppBar(
        route: RouteString.createNewCardThree,
          titleText: 'Step 4 of 4',
      ),
      backgroundColor: AppColors.defaultWhite,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            uploadPhotoMethod(cardController: cardController),
                        Center(
              child: WonderCardButton(
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
            ),
          ],
        ),
      ),
    );
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
             width:  94,
    height: 94,
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
      width:  94,
    height: 94,
            ),
    ),
  );
}

