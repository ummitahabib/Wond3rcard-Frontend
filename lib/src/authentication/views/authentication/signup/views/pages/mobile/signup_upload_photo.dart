import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';

class SignupUploadPhoto extends HookConsumerWidget {
  const SignupUploadPhoto({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.go(RouteString.signup),
          icon: const HeroIcon(HeroIcons.arrowLeft),
        ),
        title: Text(
            textAlign: TextAlign.center,
            'Upload Photo',
            style: WonderCardTypography.boldTextH5(
                fontSize: 23, color: AppColors.grayScale)),
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
    final authController = ref.watch(authProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        uploadPhotoMethod(context: context, ref: ref),
        Padding(
          padding: const EdgeInsets.all(16),
          child: WonderCardButton(
            textColor: AppColors.defaultWhite,
            showLoader: authController.loadingSignup,
            text: signUpText,
            onPressed: () {
              authController.signUp(context);
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
  final authController = ref.watch(cardProvider);

  return GestureDetector(
    onTap: () async {
      await ref.read(cardProvider).pickImage(context);
    },
    child: Center(
      child: authController.selectedPhoto != null
          ? SizedBox(
              width: 94,
              height: 94,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: authController.selectedPhoto!.bytes != null
                    ? Image.memory(
                        authController.selectedPhoto!.bytes!,
                        fit: BoxFit.cover,
                      )
                    : authController.selectedPhoto!.path != null
                        ? Image.file(
                            File(authController.selectedPhoto!.path!),
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
