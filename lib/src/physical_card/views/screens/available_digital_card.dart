import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_options.dart';
import 'package:wond3rcard/src/cards/views/widgets/no_cards_widget.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:smart_wrap/smart_wrap.dart';
import 'package:wond3rcard/src/home/views/widgets/name_and_job.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';

class AvailableDigitalCards extends StatefulHookConsumerWidget {
  AvailableDigitalCards({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AvailableDigitalCardsState();
}

class _AvailableDigitalCardsState extends ConsumerState<AvailableDigitalCards> {
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
        ? Scaffold(
            appBar: AppBar(),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: isDesktop(context)
                  ? GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: cardController
                              ?.getCardsResponse?.payload?.cards?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return _cardLists(context, cardController, index);
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cardController
                              ?.getCardsResponse?.payload?.cards?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _cardLists(context, cardController, index),
                            const SizedBox(
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

  Widget _cardLists(
      BuildContext context, CardNotifier cardController, int index) {
    final card = cardController.getCardsResponse?.payload?.cards?[index];
    return Container(
      width: 357,
      height: 260,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryShade,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          SmartWrap(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0F000000),
                                  offset: Offset(
                                    SpacingConstants.size0,
                                    SpacingConstants.size1,
                                  ),
                                  blurRadius: SpacingConstants.size2,
                                ),
                                BoxShadow(
                                  color: Color(0x1A000000),
                                  offset: Offset(
                                    SpacingConstants.size0,
                                    SpacingConstants.size1,
                                  ),
                                  blurRadius: SpacingConstants.size3,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                  SpacingConstants.size100),
                              border: Border.all(
                                  width: 4, color: AppColors.defaultWhite)),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.defaultWhite,
                            backgroundImage: NetworkImage(
                              card?.cardPictureUrl ?? ImageAssets.profileImage,
                            ),
                          ),
                        ),
                        const Spacer(),
                        NameAndJob(
                          text: card?.cardName ?? emptyString,
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
                              text: card?.cardType ?? emptyString,
                            ),
                            const Spacer(),
                            qrCodeContainer(onTap: () {
                              context.go(RouteString.shareCardLink);
                            }),
                            const SizedBox(width: 12),
                            qrCodeContainer(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CardOptions(
                                      index: index,
                                    );
                                  },
                                );
                              },
                              icon: HeroIcons.ellipsisVertical,
                              iconColor: const Color(0xff0F172A),
                            )
                          ],
                        ),
                      ),
                      // Add the "Create Physical Card" button here
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryShade,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          icon: const Icon(Icons.credit_card_rounded, size: 22),
                          label: const Text(
                            "Create Physical Card",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            print('*** userid ${card?.ownerId}');
                            print('*** cardid ${card?.id}');
                            context.go(RouteString.createPhysicalCard, extra: {
                              'userId': card?.ownerId,
                              'cardId': card?.id,
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Optional: Add a floating badge or hint
          Positioned(
            top: 12,
            right: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryShade.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Icon(Icons.local_shipping, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    "Physical Available",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
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

  Future<void> _showCreatePhysicalCardDialog(
      BuildContext context, dynamic card) async {
    final _primaryColorController = TextEditingController(text: "#FF5733");
    final _secondaryColorController = TextEditingController(text: "#33FF57");
    final String userId = card?.userId ?? '';
    final String cardId = card?.id ?? '';
    final String templateId = card?.templateId ?? '';
    final String finalDesign = card?.svgDesign ?? '';

    await showDialog(
      context: context,
      builder: (context) {
        final state = ref.watch(physicalCardControllerProvider);
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: const [
              Icon(Icons.credit_card, color: Colors.deepOrange),
              SizedBox(width: 8),
              Text("Create Physical Card"),
            ],
          ),
          content: SizedBox(
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _primaryColorController,
                  decoration: const InputDecoration(
                    labelText: 'Primary Color',
                    prefixIcon: Icon(Icons.color_lens),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _secondaryColorController,
                  decoration: const InputDecoration(
                    labelText: 'Secondary Color',
                    prefixIcon: Icon(Icons.color_lens_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                if (state.isLoading)
                  const CircularProgressIndicator()
                else if (state.hasError)
                  Text('Error: ${state.error}',
                      style: const TextStyle(color: Colors.red)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryShade,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                await ref
                    .read(physicalCardControllerProvider.notifier)
                    .createCard(
                      userId: userId,
                      cardId: cardId,
                      templateId: templateId,
                      primaryColor: _primaryColorController.text,
                      secondaryColor: _secondaryColorController.text,
                      finalDesign: finalDesign,
                    );
                if (!mounted) return;
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Physical card creation requested!"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
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
      false;
}
