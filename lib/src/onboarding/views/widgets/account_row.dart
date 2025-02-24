import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/social_media/data/model/social_media.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/add_and_close_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/behance_avatar.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class AccountRow extends HookConsumerWidget {
  final bool isExpanded;
  final SocialMedia socialController;

  const AccountRow({
    super.key,
    required this.isExpanded,
    required this.socialController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: SpacingConstants.size326,
      height: SpacingConstants.size69,
      decoration: BoxDecoration(
        color: Color(0xffEFEFEF
),
        borderRadius: BorderRadius.circular(SpacingConstants.size8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BehanceAvatar(image: socialController.link),
          SizedBox(width: 14),
          Text(
            socialController.name,
            style: WonderCardTypography.boldTextTitleBold(),
          ),
          Spacer(),
          AddAndCloseWidget(isExpanded: isExpanded),
           SizedBox(width: 16),
        ],
      ),
    );
  }
  
}
