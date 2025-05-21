import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/qr_code/data/controller/share_card_controller.dart';
import 'package:wond3rcard/src/qr_code/data/controller/share_card_qr_controller.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

//Todo rework on this file and break the widgets and method into smaller parts
class ShareQrWidget extends HookConsumerWidget {
  const ShareQrWidget({super.key, required this.index});

  final int index;

  static const routeName = RouteString.shareCardLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.read(profileProvider);
    final cardController = ref.watch(cardProvider);
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          if (profileController.profileData == null) {
            Future.delayed(Duration.zero, () async {
              final String cardId = ref
                      .read(cardProvider)
                      .getCardsResponse
                      ?.payload
                      ?.cards?[index]
                      .id ??
                  '';
              await profileController.getProfile(context);
              await ref.read(cardProvider).getAUsersCard(context, cardId);
            });
          }
        });
        return null;
      },
      [],
    );
    return Scaffold(
      backgroundColor: AppColors.primaryShade,
      appBar: AppBar(
        backgroundColor: AppColors.primaryShade,
        title: Text('Share Card',
            style: WonderCardTypography.boldTextH5(
                fontSize: 23, color: AppColors.defaultWhite)),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              context.go(RouteString.qrScanner);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.defaultWhite,
              ),
              margin: const EdgeInsets.all(10),
              child: Icon(Icons.qr_code_scanner_rounded,
                  color: AppColors.grayScale),
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            isDesktop(context)
                ? context.go(RouteString.shareCardLink)
                : context.go(RouteString.mainDashboard);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.defaultWhite,
            ),
            child: HeroIcon(HeroIcons.arrowLeft, color: AppColors.grayScale),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    SpacingConstants.size16,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // userProfileImage(),

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
                          borderRadius:
                              BorderRadius.circular(SpacingConstants.size100),
                          border: Border.all(
                              width: 4, color: AppColors.defaultWhite)),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.defaultWhite,
                        backgroundImage: NetworkImage(
                          cardController.getCardsResponse?.payload
                                  ?.cards?[index].cardPictureUrl ??
                              ImageAssets.profileImage,
                        ),
                      ),
                    ),

                    Text(
                      '${cardController.getCardsResponse?.payload?.cards?[index].firstName ?? emptyString} ${cardController.getCardsResponse?.payload?.cards?[index].lastName ?? emptyString}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: wonderCardFontName,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ShareCardWithBarCode(
                        cardId: cardController
                                .getCardsResponse?.payload?.cards![index].id ??
                            emptyString),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go(RouteString.viewCard);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        width: 229,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primaryShade,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                            child: Text('Preview Card',
                                style:
                                    TextStyle(color: AppColors.defaultWhite))),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinkContainer(
                      cardId: cardController
                              .getCardsResponse?.payload?.cards?[index].id ??
                          '',
                    ),
                    SizedBox(width: 10),
                    linkContainer('Share link', HeroIcons.arrowUpTray, () {}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector linkContainer(
    String text,
    HeroIcons icon,
    Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 158.5,
        height: 61.59,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.defaultWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontFamily: wonderCardFontName,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            HeroIcon(
              icon,
              color: AppColors.grayScale700,
            )
          ],
        ),
      ),
    );
  }
}

Container chooseCardToShare() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 23),
    width: 406,
    height: 657,
    decoration: const BoxDecoration(
      color: AppColors.grayScale50,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: const Column(
      children: [
        SearchField(),
        SizedBox(
          height: SpacingConstants.size40,
        ),
        CustomRowContainer(),
      ],
    ),
  );
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360, // Fixed width
      height: 51, // Fixed height
      padding: const EdgeInsets.fromLTRB(16, 0, 14, 0), // Padding
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2), // Adjust opacity
        borderRadius: BorderRadius.circular(8), // Rounded corners (optional)
        border: Border.all(color: Colors.grey.shade400), // Border color
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey), // Search Icon
          SizedBox(width: 10), // Gap between icon and text field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none, // Remove underline
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRowContainer extends StatelessWidget {
  const CustomRowContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 72,
      constraints: const BoxConstraints(minHeight: 72),
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userProfileImage(
            height: 60,
            width: 60,
          ),
          const Text(
            'Card name',
            style: TextStyle(
                fontFamily: wonderCardFontName,
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: AppColors.grayScale700),
          ),
          // to do if card is selected check the circle else uncheck
          const Icon(
            Icons.circle_outlined,
            color: AppColors.primaryShade,
          )
        ],
      ),
    );
  }
}

class ShareCardWithBarCode extends ConsumerStatefulWidget {
  final String cardId;

  const ShareCardWithBarCode({Key? key, required this.cardId})
      : super(key: key);

  @override
  ConsumerState<ShareCardWithBarCode> createState() =>
      _ShareCardWithBarCodeState();
}

class _ShareCardWithBarCodeState extends ConsumerState<ShareCardWithBarCode> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(shareCardQrControllerProvider.notifier).getQrCode(widget.cardId);
      ref.read(cardProvider).getAUsersCard(
            context,
            widget.cardId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final qrCodeState = ref.watch(shareCardQrControllerProvider);

    return Container(
      decoration: BoxDecoration(
        border: DashedBorder.all(
          color: AppColors.primaryShade,
          dashLength: 40,
          width: 2,
          isOnlyCorner: true,
          strokeAlign: BorderSide.strokeAlignInside,
          strokeCap: StrokeCap.round,
        ),
      ),
      child: qrCodeState.when(
        data: (qrData) => QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 229,
          gapless: false,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => QrImageView(
          data: "DUMMY_QR_CODE",
          version: QrVersions.auto,
          size: 229,
          gapless: false,
        ),
      ),
    );
  }
}

class LinkContainer extends ConsumerWidget {
  final String cardId;

  const LinkContainer({Key? key, required this.cardId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkState = ref.watch(shareCardLinkControllerProvider);

    return InkWell(
      onTap: () async {
        final notifier = ref.read(shareCardLinkControllerProvider.notifier);
        await notifier.getShareableLink(cardId);

        linkState.when(
          data: (link) {
            Clipboard.setData(ClipboardData(text: link));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Link copied to clipboard!")),
            );
          },
          loading: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Fetching link...")),
            );
          },
          error: (error, _) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to fetch link.")),
            );
          },
        );
      },
      child: Container(
        width: 158.5,
        height: 61.59,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.defaultWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Copy link',
              style: const TextStyle(
                fontFamily: wonderCardFontName,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            HeroIcon(
              HeroIcons.link,
              color: AppColors.grayScale700,
            )
          ],
        ),
      ),
    );
  }
}
