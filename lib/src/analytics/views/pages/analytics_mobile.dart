import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/analytics/views/widgets/all_cards_analytics_screen.dart';
import 'package:wond3rcard/src/analytics/views/widgets/analytics_ui_widgets.dart';
import 'package:wond3rcard/src/analytics/views/widgets/selected_card_widget.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class AnalyticsMobile extends HookConsumerWidget {
  const AnalyticsMobile({super.key});

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

    final screens = [
      const Center(child: AllCardsAnalyticsScreen()),
      SelectedCardWidget(),
    ];

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Analytics',
                  style: WonderCardTypography.boldTextH4(
                    color: AppColors.grayScale,
                    fontSize: 23,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectAnalytics(
                    text: 'All Cards',
                    isActive: analyticsController.selectedIndex == 0,
                    onTap: () {
                      ref.read(analyticsProvider).updateSelectedIndex(0);
                    },
                  ),
                  const SizedBox(width: 8),
                  SelectAnalytics(
                    icon: HeroIcons.creditCard,
                    text: 'Select Card',
                    isActive: analyticsController.selectedIndex == 1,
                    onTap: () {
                      analyticsController.updateSelectedIndex(1);
                    },
                  ),
                ],
              ),
              Expanded(
                child: screens[analyticsController.selectedIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
