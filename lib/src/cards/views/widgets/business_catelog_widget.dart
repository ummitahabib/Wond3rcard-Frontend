import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';

class BusinessCatalogWidget extends HookConsumerWidget {
  const BusinessCatalogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.read(cardProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await cardController.getAllUsersCard();
      });
      return null;
    }, []);

    final cards = cardController.getCardsResponse?.payload?.cards;

    return Container(
      margin: const EdgeInsets.all(12),
      width: 392,
      height: 320,
      padding: const EdgeInsets.all(20),
      decoration: (cards != null &&
              cards.isNotEmpty &&
              cards.any((card) =>
                  card.catalogue != null && card.catalogue!.isNotEmpty))
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            )
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: cards == null || cards.isEmpty
                  ? Text(
                      'My Business Catalogue',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : SizedBox()),
          const SizedBox(height: 10),
          Expanded(
            child: cards == null || cards.isEmpty
                ? const SizedBox()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: cards.expand<Widget>((card) {
                        final catalogueList = card.catalogue;
                        if (catalogueList == null || catalogueList.isEmpty) {
                          return [const SizedBox()];
                        }
                        return catalogueList.map<Widget>((catalog) {
                          // Assuming catalog is an object with imagePath, name, and description
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        catalog.imagePath ??
                                            'assets/images/placeholder.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  catalog.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  catalog.description ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
