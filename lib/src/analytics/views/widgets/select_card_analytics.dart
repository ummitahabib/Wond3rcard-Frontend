import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/views/widgets/chart_column.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/home/views/widgets/name_and_job.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/custom_app_bar.dart';
import 'package:wond3rcard/src/utils/ui_data.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

class SelectCardAnalytics extends HookConsumerWidget {
  const SelectCardAnalytics({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.read(cardProvider);
    final profileController = ref.watch(profileProvider);
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final cardController = ref.read(cardProvider);
          final profileController = ref.watch(profileProvider);
          if (cardController.cards.isEmpty) {
            Future.delayed(Duration.zero, () async {
              await cardController.getAllUsersCard();
              await profileController.getProfile(context);
            });
          }
        });
        return null;
      },
      [],
    );

    final selectedFilter = useState<String>('All');

    return Scaffold(
        appBar: CustomAppBar(
            leading: GestureDetector(
              onTap: () {
                context.go(RouteString.analytics);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.defaultWhite,
                    borderRadius: BorderRadius.circular(10)),
                child: const HeroIcon(
                  HeroIcons.arrowLeft,
                  color: AppColors.grayScale,
                ),
              ),
            ),
            title: 'Card analytics'),
        body: Column(
          children: [
            mainCard(cardController, profileController),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildFilterRow(selectedFilter),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Displaying data for: ${selectedFilter.value}',
                  style: const TextStyle(
                      fontSize: 16, color: AppColors.grayScale700),
                ),
              ),
            ),
            const ChartColumn(),
          ],
        ));
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

  Widget buildFilterRow(ValueNotifier<String> selectedFilter) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filterOptions.map((filter) {
          final isSelected = selectedFilter.value == filter.label;
          return GestureDetector(
            onTap: () {
              selectedFilter.value = filter.label;
              filter.onTap();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryShade
                    : AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(100),
                border: isSelected
                    ? Border.all(color: AppColors.primaryShade, width: 2)
                    : Border.all(color: AppColors.grayScale300),
              ),
              child: Text(
                filter.label,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.defaultWhite
                      : AppColors.grayScale700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
