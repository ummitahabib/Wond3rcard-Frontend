import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/card.dart'
    as model;
import 'package:wond3rcard/src/cards/data/model/test/get_card/getcard.dart' as model show CardData;
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';

final selectedCardProvider = StateProvider<model.CardData?>((ref) => null);

class ListOfDropDownCards extends HookConsumerWidget {
  const ListOfDropDownCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.watch(cardProvider);
    final selectedCard = ref.watch(selectedCardProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final cardController = ref.read(cardProvider);
        final profileController = ref.read(profileProvider);
        if (cardController.getCardsResponse == null) {
          await cardController.getAllUsersCard();
          await profileController.getProfile(context);
        } else if (ref.read(selectedCardProvider) == null) {
          final cards = cardController.getCardsResponse?.payload?.cards;
          if (cards != null && cards.isNotEmpty) {
              selectedCard.state = cards.first;
          }
        }
      });
      return null;
    }, []);

    final card = ref.watch(selectedCardProvider);

    if (card == null ||
        cardController.getCardsResponse?.payload?.cards == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final cards = cardController.getCardsResponse!.payload!.cards!;

    return GestureDetector(
      onTap: () => _showCardSelectionModal(context, cards, selectedCard),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(card.cardPictureUrl ?? ''),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.cardName ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
             
                  Text(
                    card.designation ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showCardSelectionModal(
    BuildContext context,
    List<model.CardData> cards,
    StateController<model.CardData?> selectedCard,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: cards.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final card = cards[index];
            final isSelected = card.cardName == selectedCard.state?.cardName;

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(card.cardPictureUrl ?? ''),
              ),
              title: Text(
                card.cardName ?? '',
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              subtitle: Text(card.designation ?? ''),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
              onTap: () {
                selectedCard.state = card;
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }


}
