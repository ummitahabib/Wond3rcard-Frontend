import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/social_media/data/model/social_media.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/cards/views/widgets/get_social_media.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

// class CreateNewCardStepFive extends HookConsumerWidget {
//   const CreateNewCardStepFive({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cardController = ref.watch(cardProvider);
//     final selectedLinks = useState<List<SocialMediaLink>>([]);

//     return Scaffold(
//       appBar: CreateCardReusableAppBar(
//         route: RouteString.createNewCardFour,
//         titleText: 'Step 5 of 5',
//       ),
//       body: SingleChildScrollView(
//         child: isDesktop(context)
//             ? Center(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width / 4,
//                   padding: EdgeInsets.all(20),
//                   margin: EdgeInsets.all(20),
//                   child: _newCardStep5(
//                       cardController, ref, context, selectedLinks),
//                 ),
//               )
//             : _newCardStep5(cardController, ref, context, selectedLinks),
//       ),
//     );
//   }

//   Column _newCardStep5(
//     CardNotifier cardController,
//     WidgetRef ref,
//     BuildContext context,
//     ValueNotifier<List<SocialMediaLink>> selectedLinks,
//   ) {
//     final List<Map<String, dynamic>> formattedLinks =
//         selectedLinks.value.map((e) => e.toJson()).toList();

//     return Column(
//       children: [
//         SocialMediaList(selectedLinks: selectedLinks),
//         Padding(
//           padding: const EdgeInsets.all(15),
//           child: WonderCardButton(
//             textColor: AppColors.defaultWhite,
//             showLoader: cardController.loading,
//             text: 'Submit',
//             onPressed: () async {
//               try {
//                 await ref.read(cardProvider).createCard(
//                       context,
//                       formattedLinks,
//                     );
//               } catch (e) {
//                 print('❌ Error creating card: $e');
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }



class CreateNewCardStepFive extends HookConsumerWidget {
  const CreateNewCardStepFive({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.watch(cardProvider);
    final selectedLinks = useState<List<SocialMedia>>([]);

    return Scaffold(
      appBar: CreateCardReusableAppBar(
        route: RouteString.createNewCardFour,
        titleText: 'Step 5 of 5',
      ),
      body: SingleChildScrollView(
        child: isDesktop(context)
            ? Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  child: _newCardStep5(
                      cardController, ref, context, selectedLinks),
                ),
              )
            : _newCardStep5(cardController, ref, context, selectedLinks),
      ),
    );
  }

  Column _newCardStep5(
    CardNotifier cardController,
    WidgetRef ref,
    BuildContext context,
    ValueNotifier<List<SocialMedia>> selectedLinks,
  ) {
    return Column(
      children: [
        GetSocialMedia(selectedLinks: selectedLinks),
        Padding(
          padding: const EdgeInsets.all(15),
          child: WonderCardButton(
              textColor: AppColors.defaultWhite,
              showLoader: cardController.loading,
              text: 'Submit',
              onPressed: () async {
                try {
                  final socialLinks =
                      selectedLinks.value.map((link) => link.toMap()).toList();
                  await ref.read(cardProvider).createCard(
                        context,
                        socialLinks,
                      );
                } catch (e) {
                  print('❌ Error creating card: $e');
                }
              }),
        ),
      ],
    );
  }
}
