import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
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
      body: isDesktop(context)
          ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                child: _uploadMethod(context, ref),
              ),
            )
          : _uploadMethod(context, ref),
    );
  }

  Column _uploadMethod(BuildContext context, WidgetRef ref) {
    final cardController = ref.watch(cardProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        uploadPhotoMethod(context: context, ref: ref),
        Padding(
          padding: const EdgeInsets.all(16),
          child: WonderCardButton(
            textColor: AppColors.defaultWhite,
            showLoader: cardController.loading,
            text: 'Save and Continue',
            onPressed: () async {
              if (!context.mounted) return;
              context.go(RouteString.createNewCardStepFive);
            },
          ),
        ),
      ],
    );
  }
}

GestureDetector uploadPhotoMethod({
  required BuildContext context,
  required WidgetRef ref,
}) {
  final cardController = ref.watch(cardProvider);

  return GestureDetector(
    onTap: () async {
      await ref.read(cardProvider).pickImage(context);
    },
    child: Center(
      child: cardController.selectedPhoto != null
          ? SizedBox(
              width: 94,
              height: 94,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: cardController.selectedPhoto!.bytes != null
                    ? Image.memory(
                        cardController.selectedPhoto!.bytes!,
                        fit: BoxFit.cover,
                      )
                    : cardController.selectedPhoto!.path != null
                        ? Image.file(
                            File(cardController.selectedPhoto!.path!),
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image),
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
