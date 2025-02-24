import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_wrap/smart_wrap.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_social_links.dart';
import 'package:wond3rcard/src/cards/views/widgets/main_card_widget.dart';
import 'package:wond3rcard/src/home/views/widgets/name_and_job.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/custom_app_bar.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/back_navigator.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/decoration_box.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';

Container deleteCardWidget({Color? color}) {
  return Container(
      decoration: DecorationBox.cardBoxDecoration(color: color),
      child: Expanded(
        child: Column(children: [
          Text(
            deleteCard,
            style: WonderCardTypography.boldTextH4(
              color: AppColors.grayScale,
              fontSize: SpacingConstants.size28,
            ),
          ),
          Text(
            textAlign: TextAlign.left,
            deleteCardConfirmation,
            style: WonderCardTypography.regularTextTitle1(),
          ),
          WonderCardButton(
            text: delete,
            onPressed: () async {},
            backgroundColor: AppColors.defaultWhite,
            borderRadius: BorderRadius.circular(SpacingConstants.size8),
            buttonWidth: size347,
          ),
          WonderCardButton(
            text: cancel,
            onPressed: () async {},
            backgroundColor: AppColors.grayScale,
            borderRadius: BorderRadius.circular(SpacingConstants.size8),
            buttonWidth: size347,
          ),
        ]),
      ));
}

Container duplicateCardWidget({Color? color}) {
  return Container(
      decoration: DecorationBox.cardBoxDecoration(color: color),
      child: Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              cardRow(
                text: duplicateCardText,
              ),
              cardRow(
                text: duplicateAndEditCardText,
              )
            ]),
      ));
}

GestureDetector cardRow({
  Color? color,
  String? text,
  Color? iconColor,
  HeroIcons? icon,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(SpacingConstants.size8),
      ),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon == null
                ? const SizedBox()
                : HeroIcon(
                    icon ?? HeroIcons.documentDuplicate,
                    color: iconColor ?? AppColors.grayScale700,
                  ),
            const SizedBox(
              height: SpacingConstants.size15,
            ),
            Text(
              text!,
              style: WonderCardTypography.boldTextTitleBold(
                color: AppColors.grayScale700,
                fontSize: SpacingConstants.size18,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Container cardOptionWidget() {
  return Container(
    decoration: DecorationBox.cardBoxDecoration(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(SpacingConstants.size8),
          child: Text(
            'Ummeeta Habeeb',
            style: WonderCardTypography.boldTextH5(),
          ),
        ),
        cardRow(
          onTap: () {},
          text: editCard,
          icon: HeroIcons.pencilSquare,
        ),
        cardRow(
          onTap: () {},
          text: shareCard,
          icon: HeroIcons.paperAirplane,
        ),
        cardRow(
          onTap: () {},
          text: shareCard,
        ),
        cardRow(
          onTap: () {},
          text: downloadCard,
          icon: HeroIcons.trash,
        ),
      ],
    ),
  );
}

WonderCardButton saveContactButton() {
  return WonderCardButton(
    onPressed: () {},
    text: saveContact,
    backgroundColor: AppColors.primaryShade,
    buttonWidth: size225,
    borderRadius: BorderRadius.circular(SpacingConstants.size10),
  );
}

Container shareCardWidget() {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.defaultWhite,
      borderRadius: BorderRadius.circular(SpacingConstants.size10),
    ),
    padding: const EdgeInsets.all(size9),
    width: size66,
    height: SpacingConstants.size60,
    child: const HeroIcon(
      HeroIcons.arrowsUpDown,
      color: AppColors.primaryShade,
      size: SpacingConstants.size45,
    ),
  );
}

Container cardSocialContainer() {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingConstants.size12)),
    padding: const EdgeInsets.symmetric(
      vertical: SpacingConstants.size20,
      horizontal: SpacingConstants.size10,
    ),
    width: size341,
    height: size918,
    child: const Expanded(
        child: Column(
      children: [
        // todo add social connections widget
      ],
    )),
  );
}

Container mainCard(
  CardNotifier? cardController,
  ProfileNotifier? profileController,
) {
  final profile = profileController?.profileData?.payload.profile;

  return Container(
    decoration: const BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    width: 357,
    height: 230,
    child: 
    Column(
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
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  connectText(
                    text: '${profile!.connections.length}',
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userProfileImage(
                        image: profile.profileUrl,
                      ),
                      const Spacer(),
                      const NameAndJob(),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      personalProfileTag(),
                      const Spacer(),
                      qrCodeContainer(),
                      qrCodeContainer(
                        icon: HeroIcons.ellipsisVertical,
                        iconColor: const Color(0xff0F172A),
                      ),
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
              await profileController.getProfile();
            });
          }
        });
        return null;
      },
      [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.cardController!.getCardsResponse?.payload?.cards?.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: (){
                    context.go(RouteString.cardDetails, extra:  widget.cardController!.getCardsResponse?.payload?.cards![index].id);
                  
                  },
                  child: Container(
                    width: 357,
                             height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryShade,
                    ),
                  
                    child:     SmartWrap(
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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userProfileImage(
                            image: cardController.getCardsResponse?.payload?.cards?[index].cardPictureUrl ?? ImageAssets.profileImage, 
                          ),
                          const Spacer(),
                           NameAndJob(
                            text: cardController.getCardsResponse?.payload?.cards?[index].cardName ?? emptyString,
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
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            personalProfileTag(
                              text: cardController.getCardsResponse?.payload?.cards?[index].cardType  ?? emptyString,
                            ),
                            const Spacer(),
                            qrCodeContainer(),
                            SizedBox(width: 12),
                            qrCodeContainer(
                              icon: HeroIcons.ellipsisVertical,
                              iconColor: const Color(0xff0F172A),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                            ),
                          ),
                        ],
                      ),
                  
                  ),
                ),
             SizedBox(height: 13,),
              ],
            );
          
          },
        ),
      ),
    );
  }
}
