import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_widgets.dart';
import 'package:wond3rcard/src/cards/views/widgets/no_cards_widget.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:smart_wrap/smart_wrap.dart';
import 'package:wond3rcard/src/home/views/widgets/name_and_job.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';

class CardListWidget extends StatefulHookConsumerWidget {
  CardListWidget({super.key, this.cardController});

  CardNotifier? cardController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends ConsumerState<CardListWidget> {
  @override
  Widget build(BuildContext context) {
    final cardController = ref.read(cardProvider);
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final cardController = ref.read(cardProvider);
          final profileController = ref.watch(profileProvider);
          if (cardController.getCardsResponse == null) {
            Future.delayed(Duration.zero, () async {
              await cardController.getAllUsersCard();
              await profileController.getProfile(context);
            });
          }
        });
        return null;
      },
      [],
    );

    return cardController.getCardsResponse != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget
                    .cardController!.getCardsResponse?.payload?.cards?.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go('${RouteString.cardDetails}/$index');
                        },
                        onDoubleTap: () async {
                          bool confirmDelete = await _showDeleteDialog(context);
                          if (confirmDelete) {
                            await ref.read(cardProvider).deleteCard(
                                cardController.getCards[index].id, context);
                          }
                        },
                        child: _cardLists(cardController, index),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        : NoCardsWidget();
  }

  Container _cardLists(CardNotifier cardController, int index) {
    return Container(
      width: 357,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryShade,
      ),
      child: SmartWrap(
        type: WrapType.column,
        spacing: 10.0,
        runSpacing: 10.0,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryShade,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userProfileImage(
                      image: cardController.getCardsResponse?.payload
                              ?.cards?[index].cardPictureUrl ??
                          ImageAssets.profileImage,
                    ),
                    const Spacer(),
                    NameAndJob(
                      text: cardController.getCardsResponse?.payload
                              ?.cards?[index].cardName ??
                          emptyString,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        personalProfileTag(
                          text: cardController.getCardsResponse?.payload
                                  ?.cards?[index].cardType ??
                              emptyString,
                        ),
                        const Spacer(),
                        qrCodeContainer(
                          onTap: (){
                            context.go(RouteString.shareCardLink);
                          }
                        ),
                        SizedBox(width: 12),
                       qrCodeContainer(
                           onTap: () {
                         showModalBottomSheet(
                           context: context,
                           builder: (BuildContext context) {
                             return cardOptionWidget(); 
                           },
                         );
                       },
                         icon: HeroIcons.ellipsisVertical,
                         iconColor: const Color(0xff0F172A),
                       )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> _showDeleteDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Card"),
            content: const Text(
                "Are you sure you want to delete this card? This action cannot be undone."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Cancel
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Confirm
                child: const Text("Yes, Delete"),
              ),
            ],
          );
        },
      ) ??
      false; // Default to false if the dialog is dismissed
}
