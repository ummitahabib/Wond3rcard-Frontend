import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:shimmer/shimmer.dart';

class PhysicalCardWidget extends HookConsumerWidget {
  PhysicalCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Load full card data on first build
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(fullCardListProvider.notifier).loadCardsForUser(context);
      });
      return null;
    }, []);

    final fullCardsAsync = ref.watch(fullCardListProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My orders',
                style: TextStyle(
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 200,
                height: 40,
                child: WonderCardButton(
                  backgroundColor: AppColors.primaryShade,
                  textColor: AppColors.defaultWhite,
                  text: 'Create Physical Card',
                  onPressed: () {
                    context.go(RouteString.availableDigitalCards);
                  },
                ),
              )
            ],
          ),
        ),
        fullCardsAsync.when(
          loading: () => _PhysicalCardShimmerList(),
          error: (e, st) => Text('Error loading cards: $e'),
          data: (cards) {
            if (cards.isEmpty) {
              return const Text("No cards available.");
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return GestureDetector(
                  onTap: () {
                    context.go(RouteString.orderPhysicalCard);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.defaultWhite,
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.primaryShade,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned.fill(
                              child: ClipOval(
                                child: Image.network(
                                  ImageAssets.bgBlur,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.payload?.cards?.isNotEmpty == true
                                    ? card.payload!.cards!.first.cardName ??
                                        'Unknown Card'
                                    : 'Unknown Card',
                                style: WonderCardTypography.boldTextH5(
                                  fontSize: 23,
                                  color: AppColors.grayScale700,
                                ),
                              ),
                              Text(
                                card.payload?.cards?.isNotEmpty == true
                                    ? card.payload!.cards!.first.designation ??
                                        'No Designation'
                                    : 'No Designation',
                                style: WonderCardTypography.regularTextTitle2(
                                  fontSize: 16,
                                  color: AppColors.grayScale600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.grayScale600,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _PhysicalCardShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 80,
                          height: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
