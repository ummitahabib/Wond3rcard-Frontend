import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: WonderCardButton(
                  showLoader: cardController.loading,
                  text: 'Save and Continue',
                  onPressed: () async {
                    try {
                              context.go(RouteString.createNewCardStepFive);
                    } catch (e) {
                      print('Error: $e');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// // GestureDetector uploadPhotoMethod({

//   required CardNotifier cardController,
// }) {
//   return GestureDetector(
//     onTap: () => cardController.pickImage(),
//     child: Center(
//       child: cardController.uploadedImage != null || cardController.webImage != null
//           ? SizedBox(
//               width: 94,
//               height: 94,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(100),
//                 child: kIsWeb
//                     ? Image.memory(cardController.webImage!, fit: BoxFit.cover)
//                     : Image.file(cardController.uploadedImage!, fit: BoxFit.cover),
//               ),
//             )
//           : Image.asset(
//               ImageAssets.profileImage,
//               width: 94,
//               height: 94,
//             ),
//     ),
//   );
// }


GestureDetector uploadPhotoMethod({
  required CardNotifier cardController,
}) {
  return GestureDetector(
    onTap: () async {
      await cardController.pickImage();
    },
    child: Center(
      child: (cardController.cardPhoto != null || cardController.webCardPhoto != null)
          ? SizedBox(
              width: 94,
              height: 94,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: kIsWeb
                    ? Image.memory(cardController.webCardPhoto!, fit: BoxFit.cover)
                    : Image.file(cardController.cardPhoto!, fit: BoxFit.cover),
              ),
            )
          : Image.asset(
             ImageAssets.profileImage,
              width: 94,
              height: 94,
            ),
    ),
  );
}
