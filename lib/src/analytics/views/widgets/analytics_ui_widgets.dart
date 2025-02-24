import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

// todo : will create a method that will display all cards  analytics if  tap on the all cards button
// or display selected card analytics if tp on selected card button
class SelectAnalytics extends StatelessWidget {
  const SelectAnalytics({
    super.key,
    this.text,
    this.icon,
    this.onTap,
    this.isActive,
  });

  final String? text;
  final HeroIcons? icon;
  final void Function()? onTap;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 160,
          height: 40,
          margin: const EdgeInsets.only(
              bottom: 6), // Gap (applied via margin for spacing)
          decoration: BoxDecoration(
            color: isActive! ? AppColors.primaryShade : AppColors.defaultWhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HeroIcon(
                  icon ?? HeroIcons.chartBar,
                  color: AppColors.defaultWhite,
                ),
                Text(text ?? emptyString,
                    style: WonderCardTypography.boldTextTitle2(
                      color: isActive!
                          ? AppColors.defaultWhite
                          : AppColors.primaryShade,
                      fontSize: 16,
                    ))
              ],
            ),
          )),
    );
  }
}

class AnalyticsByDayOrAny extends HookConsumerWidget {
  const AnalyticsByDayOrAny({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class GeographicDistribution extends HookConsumerWidget {
  const GeographicDistribution({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class AnalyticsUi extends HookConsumerWidget {
  const AnalyticsUi({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsController = ref.read(analyticsProvider);
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final analyticsController = ref.read(analyticsProvider);
          if (analyticsController.analyticsModel.isEmpty) {
            Future.delayed(Duration.zero, () async {
              await analyticsController.getInteraction();
            });
          }
        });
        return null;
      },
      [],
    );

    return Container(
      child: Column(
        children: [
          Text(analyticsController
              .analyticsModel.first.payload.analytics.totalContacts
              .toString())
        ],
      ),
    );
  }
}
