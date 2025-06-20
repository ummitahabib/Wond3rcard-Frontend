import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/onboarding/views/pages/mobile/onboarding_fifth_screen_mobile.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class EditCardFifthScreen extends HookConsumerWidget {
  const EditCardFifthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.watch(cardProvider);
    final cardModel = cardController.cardModel;

    final selectedLinks = useState<List<SocialMediaLink>>(
      (cardModel?.socialMediaLinks ?? []).cast<SocialMediaLink>(),
    );

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
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  child: _editCardStep5(
                      cardController, ref, context, selectedLinks),
                ),
              )
            : _editCardStep5(cardController, ref, context, selectedLinks),
      ),
    );
  }

  Column _editCardStep5(
    CardNotifier cardController,
    WidgetRef ref,
    BuildContext context,
    ValueNotifier<List<SocialMediaLink>> selectedLinks,
  ) {
    final List<Map<String, dynamic>> formattedLinks =
        selectedLinks.value.map((e) => e.toJson()).toList();

    return Column(
      children: [
        SocialMediaList(selectedLinks: selectedLinks),
        const SizedBox(height: 20),
        WonderCardButton(
          textColor: AppColors.defaultWhite,
          showLoader: cardController.loading,
          text: 'Update Card',
          onPressed: () async {
            try {
              // Call editCard instead of createCard
              await ref.read(cardProvider).editCard(
                    context,
                    formattedLinks,
                  );
            } catch (e, stack) {
              print('❌ Error updating card: $e');
              debugPrintStack(stackTrace: stack);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to update card. Please try again.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
