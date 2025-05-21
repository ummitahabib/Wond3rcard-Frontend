import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/card.dart'
    as model;
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';

class ListOfDropDownCards extends HookConsumerWidget {
  const ListOfDropDownCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.read(cardProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final cardController = ref.read(cardProvider);
          final profileController = ref.watch(profileProvider);
          if (cardController.getCardsResponse == null) {
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

    final selectedCard = useState<model.Card>(
        cardController.getCardsResponse!.payload!.cards!.first);

    return GestureDetector(
      onTap: () => _showCardSelectionModal(context,
          cardController.getCardsResponse!.payload!.cards!, selectedCard),
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
              backgroundImage:
                  NetworkImage(selectedCard.value.cardPictureUrl ?? ''),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedCard.value.cardName ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    selectedCard.value.designation ?? '',
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
    List<model.Card> cards,
    ValueNotifier<model.Card> selectedCard,
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
            final isSelected = card.cardName == selectedCard.value.cardName;

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  card.cardPictureUrl ?? '',
                ),
              ),
              title: Text(
                card.cardName ?? '',
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              subtitle: Text(
                card.designation ?? '',
              ),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
              onTap: () {
                selectedCard.value = card;
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
