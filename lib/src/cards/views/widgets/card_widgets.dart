import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/home/views/widgets/name_and_job.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
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
          SizedBox(
              width: size347,
            child: WonderCardButton(
              text: delete,
              onPressed: () async {},
              backgroundColor: AppColors.defaultWhite,
              borderRadius: BorderRadius.circular(SpacingConstants.size8),
            
            ),
          ),
          SizedBox(
             width: size347,
            child: WonderCardButton(
              text: cancel,
              onPressed: () async {},
              backgroundColor: AppColors.grayScale,
              borderRadius: BorderRadius.circular(SpacingConstants.size8),
             
            ),
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
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color ?? AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(SpacingConstants.size8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon == null
              ? const SizedBox()
              : HeroIcon(
                  icon ?? HeroIcons.documentDuplicate,
                  color: iconColor ?? AppColors.grayScale700,
                ),
          Spacer(),
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
  );
}

Widget saveContactButton() {
  return SizedBox(
       width: size225,
    child: WonderCardButton(
      onPressed: () {},
      text: saveContact,
      backgroundColor: AppColors.primaryShade,
      borderRadius: BorderRadius.circular(SpacingConstants.size10),
    ),
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
    child: Column(
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
