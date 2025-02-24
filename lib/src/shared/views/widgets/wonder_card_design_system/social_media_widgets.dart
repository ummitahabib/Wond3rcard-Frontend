import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class SocialMediaWidget extends HookConsumerWidget {
  const SocialMediaWidget(
      {super.key, required this.asset, required this.title});
  final String asset;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: AppColors.transparent,
        width: SpacingConstants.size101,
        height: SpacingConstants.size130,
        child: Column(
          children: [
            Image.asset(
              asset,
              width: SpacingConstants.size70,
              height: SpacingConstants.size70,
            ),
            Text(
              title,
              style: WonderCardTypography.regularTextTitle2(),
            )
          ],
        ),
      ),
    );
  }
}

class SocialMediaIcons {
  final String title;
  final String asset;
  final String route;
  SocialMediaIcons({
    required this.title,
    required this.asset,
    required this.route,
  });
}

List<SocialMediaIcons> socialMediaItems = [
  SocialMediaIcons(
    asset: 'ig.png',
    route: '/ig.dart',
    title: 'Instagram',
  )
];
