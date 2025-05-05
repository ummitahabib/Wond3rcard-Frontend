import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';

class HomeAddressWidget extends HookConsumerWidget {
  const HomeAddressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.read(cardProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await cardController.getAllUsersCard();
        });
        return null;
      },
      [],
    );

    final addresses = cardController.getCardsResponse?.payload?.cards
        ?.expand((card) => card.contactInfo?.addresses ?? [])
        .toList();

    return Column(
      children: [
        const Text(
          'Business Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 345,
          height: 200,
          child: ListView.builder(
            itemCount: addresses?.length,
            itemBuilder: (context, index) {
              final address = addresses?[index];
              return Column(
                children: [
                  Container(
                    width: 345,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const HeroIcon(HeroIcons.home),
                                const SizedBox(width: 8),
                                Text(
                                  address.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              address.streetAddress,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const HeroIcon(
                            HeroIcons.map,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
