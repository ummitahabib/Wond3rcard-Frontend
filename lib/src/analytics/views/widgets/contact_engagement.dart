import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/analytics/views/widgets/all_cards_analytics_screen.dart';
import 'package:wond3rcard/src/analytics/views/widgets/analytics_ui_widgets.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ContactEngagement extends HookConsumerWidget {
  const ContactEngagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsController = ref.watch(analyticsProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final analyticsController = ref.read(analyticsProvider);
          if (analyticsController.analytics == null) {
            Future.delayed(Duration.zero, () async {
              await analyticsController.getInteraction();
            });
          }
        });
        return null;
      },
      [],
    );

    return Column(
      children: [
        //  Card(
        //         color: AppColors.defaultWhite,
        //         surfaceTintColor: AppColors.defaultWhite,
        //         shape:
        //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        Container(
          decoration: BoxDecoration(
            color: AppColors.defaultWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          height: 187,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Contact Engagement',
                    style: WonderCardTypography.boldTextTitleBold(
                      color: AppColors.grayScale,
                      fontSize: 18,
                    ),
                  ),
                  contactEngagementChildren(
                    numberOfTaps:
                        '${analyticsController.analytics?.payload.analytics.totalPhone ?? emptyString}',
                    text: 'Phone',
                    icon: HeroIcons.phone,
                  ),
                  contactEngagementChildren(
                    numberOfTaps:
                        '${analyticsController.analytics?.payload.analytics.totalEmail ?? emptyString}',
                    text: 'Email',
                    icon: HeroIcons.inbox,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row contactEngagementChildren(
      {required String text,
      required HeroIcons icon,
      required String numberOfTaps}) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.primaryShade,
          ),
          child: HeroIcon(
            icon,
            color: AppColors.defaultWhite,
            size: 20,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          text,
          style: WonderCardTypography.boldTextTitle2(
              color: AppColors.grayScale, fontSize: 16),
        ),
        const Spacer(),
        Row(
          children: [
            Text(numberOfTaps,
                style: WonderCardTypography.boldTextH5(
                  color: AppColors.grayScale,
                  fontSize: 23,
                )),
            Text(
              'Taps',
              style: WonderCardTypography.captionBold(),
            ),
          ],
        )
      ],
    );
  }
}
