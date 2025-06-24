import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_options.dart';
import 'package:wond3rcard/src/cards/views/widgets/no_cards_widget.dart';
import 'package:heroicons/heroicons.dart';
import 'package:smart_wrap/smart_wrap.dart';
import 'package:wond3rcard/src/home/views/widgets/name_and_job.dart';

class HomeDesktop extends StatefulHookConsumerWidget {
  const HomeDesktop({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends ConsumerState<HomeDesktop> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final profileController = ref.watch(profileProvider);
          if (profileController.profileData == null) {
            Future.delayed(Duration.zero, () async {
              await profileController.getProfile(context);
              await ref.read(cardProvider).getAllUsersCard();
            });
          }
        });
        return null;
      },
      [],
    );
    final profileController = ref.watch(profileProvider);
    final profile = profileController.profileData?.payload.profile;
    final user = profileController.profileData?.payload.user;
    final cardControler = ref.watch(cardProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: _isDarkMode ? Colors.black87 : AppColors.primaryShade,
              padding: const EdgeInsets.all(32),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome Back, ${profile?.firstname ?? ''} ${profile?.lastname ?? ''}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your Dashboard",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      color: _isDarkMode ? Colors.black87 : Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                profile?.profileUrl ?? defaultProfileImage,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${profile?.firstname ?? ''} ${profile?.lastname ?? ''},',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${profile?.email ?? ''}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${profile?.companyName ?? ''}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${profile?.designation ?? ''}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      personalProfileTag(),
                                      qrCodeContainer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      color: _isDarkMode ? Colors.black87 : Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    'Cards Created',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Barlow',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                      textAlign: TextAlign.center,
                                      '${cardControler.getCards.length.toString()}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Barlow',
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    'Connected',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Barlow',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                      textAlign: TextAlign.center,
                                      '${profile?.connections.length} +',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Barlow',
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Recent Cards Created',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.go(RouteString.cardMain);
                        },
                        child: Text(
                          'View More',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  DesktopCardList(
                    cardController: cardControler,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DesktopCardList extends StatefulHookConsumerWidget {
  DesktopCardList({super.key, this.cardController});

  CardNotifier? cardController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DesktopCardListState();
}

class _DesktopCardListState extends ConsumerState<DesktopCardList> {
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
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.5,
              ),
              itemCount: (cardController
                              .getCardsResponse?.payload?.cards?.length ??
                          0) <
                      3
                  ? cardController.getCardsResponse?.payload?.cards?.length ?? 0
                  : 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.go('${RouteString.cardDetails}/$index');
                  },
                  onDoubleTap: () async {
                    bool confirmDelete = await _showDeleteDialog(context);
                    if (confirmDelete) {
                      await ref.read(cardProvider).deleteCard(
                            cardController.getCardsResponse?.payload
                                    ?.cards?[index].id ??
                                '',
                            context,
                          );
                    }
                  },
                  child: _cardLists(cardController, index),
                );
              },
            ))
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
                        qrCodeContainer(onTap: () {
                          context.go(RouteString.shareCardLink);
                        }),
                        SizedBox(width: 12),
                        qrCodeContainer(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return CardOptions(
                                  index: index,
                                  cardId: cardController.getCardsResponse
                                          ?.payload?.cards?[index].id ??
                                      emptyString,
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
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes, Delete"),
              ),
            ],
          );
        },
      ) ??
      false;
}
