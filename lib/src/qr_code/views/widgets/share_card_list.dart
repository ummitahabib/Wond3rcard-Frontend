import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/qr_code/views/widgets/share_card_search_field.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ShareCardList extends StatefulHookConsumerWidget {
  ShareCardList({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShareCardListState();
}

class _ShareCardListState extends ConsumerState<ShareCardList> {
  @override
  Widget build(BuildContext context) {
    final cardController = ref.read(cardProvider);
    TextEditingController searchController = TextEditingController();

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final cardController = ref.read(cardProvider);
          final profileController = ref.watch(profileProvider);
          if (cardController.cards.isEmpty) {
            Future.delayed(Duration.zero, () async {
              await cardController.getAllUsersCard();
              await profileController.getProfile();
            });
          }
        });
        return null;
      },
      [],
    );

    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Choose which card to share',
                style: WonderCardTypography.boldTextTitleBold(
                  fontSize: SpacingConstants.size18,
                  color: AppColors.grayScale,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SharedSearchField(
                controller: searchController,
                hintText: "Search here...",
                onChanged: (value) {
                  print("Searching: $value");
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cardController!
                        .getCardsResponse?.payload?.cards?.length,
                    itemBuilder: (context, index) {
                      final card = cardController!
                          .getCardsResponse?.payload?.cards?[index];
                      return Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: size8,
                                  horizontal: size19,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context.go(
                                        '${RouteString.shareCardLink}/$index');
                                  },
                                  child: Container(
                                    // width: size360,
                                    height: SpacingConstants.size72,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(size15),
                                      color: AppColors.defaultWhite,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(size12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: SpacingConstants.size45,
                                            height: SpacingConstants.size45,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SpacingConstants.size100),
                                              child: Image.network(
                                                card?.cardPictureUrl ??
                                                    ImageAssets.behance,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: size15,
                                          ),
                                          Text(
                                            card?.cardName ?? emptyString,
                                            style:
                                                WonderCardTypography.boldTextH5(
                                                    fontSize:
                                                        SpacingConstants.size23,
                                                    color:
                                                        AppColors.grayScale700),
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            Icons.circle,
                                            color: AppColors.primaryShade,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size10,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
