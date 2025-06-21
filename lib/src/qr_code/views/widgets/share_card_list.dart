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
import 'package:shimmer/shimmer.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ShareCardList extends StatefulHookConsumerWidget {
  ShareCardList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShareCardListState();
}

class _ShareCardListState extends ConsumerState<ShareCardList> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cardController = ref.read(cardProvider);
      final profileController = ref.read(profileProvider);
      if (cardController.cards.isEmpty) {
        await cardController.getAllUsersCard();
        await profileController.getProfile(context);
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardController = ref.watch(cardProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.grayScale50,
        appBar: AppBar(
          leading: const SizedBox(),
          centerTitle: true,
          title: Text(
            'Choose which card to share',
            style: WonderCardTypography.boldTextTitleBold(
              fontSize: SpacingConstants.size18,
              color: AppColors.grayScale,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: SharedSearchField(
                  controller: searchController,
                  hintText: "Search here...",
                  onChanged: (value) {
                    print("Searching: $value");
                  },
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: cardController.loading
                    ? LayoutBuilder(
                        builder: (context, constraints) {
                          final isDesktop = constraints.maxWidth > 600;
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isDesktop ? 2 : 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: isDesktop ? 3 : 2.5,
                            ),
                            itemCount: 5,
                            itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: SpacingConstants.size72,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(size15),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : (cardController.getCardsResponse?.payload?.cards?.isEmpty ??
                            true)
                        ? Center(
                            child: Text(
                              "No cards available",
                              style: WonderCardTypography.boldTextH5(
                                fontSize: SpacingConstants.size18,
                                color: AppColors.grayScale700,
                              ),
                            ),
                          )
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              return isDesktop(context)
                                  ? GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 4,
                                      ),
                                      itemCount: cardController.getCardsResponse
                                          ?.payload?.cards?.length,
                                      itemBuilder: (context, index) {
                                        final card = cardController
                                            .getCardsResponse
                                            ?.payload
                                            ?.cards?[index];
                                        return GestureDetector(
                                          onTap: () {
                                            context.go(
                                                '${RouteString.shareCardLink}/$index');
                                          },
                                          child: Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(size12),
                                              margin:
                                                  const EdgeInsets.all(size12),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(size15),
                                                color: AppColors.defaultWhite,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        SpacingConstants.size45,
                                                    height:
                                                        SpacingConstants.size45,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              SpacingConstants
                                                                  .size100),
                                                      child: Container()
                                                      //temp
                                                      // Image.network(
                                                      //   card?.cardPictureUrl ??
                                                      //       ImageAssets.behance,
                                                      //   fit: BoxFit.cover,
                                                      // ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: size15),
                                                  Expanded(
                                                    child: Text(
                                                      card?.cardName ??
                                                          emptyString,
                                                      style: WonderCardTypography
                                                          .boldTextH5(
                                                        fontSize: SpacingConstants
                                                            .size23,
                                                        color: AppColors
                                                            .grayScale700,
                                                      ),
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.circle,
                                                    color: AppColors.primaryShade,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      itemCount: cardController.getCardsResponse
                                          ?.payload?.cards?.length,
                                      itemBuilder: (context, index) {
                                        final card = cardController
                                            .getCardsResponse
                                            ?.payload
                                            ?.cards?[index];
                                        return Padding(
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
                                              height: SpacingConstants.size72,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(size15),
                                                color: AppColors.defaultWhite,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(size12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          SpacingConstants.size45,
                                                      height:
                                                          SpacingConstants.size45,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                SpacingConstants
                                                                    .size100),
                                                        child: Container()
                                                        //temp
                                                        // Image.network(
                                                        //   card?.cardPictureUrl ??
                                                        //       ImageAssets.behance,
                                                        //   fit: BoxFit.cover,
                                                        // ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: size15),
                                                    Text(
                                                      card?.cardName ??
                                                          emptyString,
                                                      style: WonderCardTypography
                                                          .boldTextH5(
                                                        fontSize: SpacingConstants
                                                            .size23,
                                                        color: AppColors
                                                            .grayScale700,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    const Icon(
                                                      Icons.circle,
                                                      color:
                                                          AppColors.primaryShade,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
