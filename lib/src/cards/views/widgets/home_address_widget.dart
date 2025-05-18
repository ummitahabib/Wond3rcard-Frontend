import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wond3rcard/src/utils/util.dart';

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








class BusinessAddressSection extends StatelessWidget {
  final String? businessName;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;

  const BusinessAddressSection({
    super.key,
    this.businessName,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  String get fullAddress {
    final parts = [address, city, state, postalCode, country];
    return parts.where((part) => part != null && part.trim().isNotEmpty).join(', ');
  }

  void _openInMaps(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = 'https://www.google.com/maps/search/?api=1&query=$encodedQuery';

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open the map for: $query");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (fullAddress.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      color: AppColors.defaultWhite,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              businessName ?? 'Business Address',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              fullAddress,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () => _openInMaps(fullAddress),
                icon: const Icon(Icons.map),
                label: const Text('Open in Maps'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
