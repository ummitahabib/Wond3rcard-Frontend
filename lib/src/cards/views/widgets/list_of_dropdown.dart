import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ListOfDropDownCards extends HookWidget {
  const ListOfDropDownCards({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CardModel> dummyCards = [
      CardModel(
        cardName: 'Wonder Tech',
        designation: 'Software Engineer',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      CardModel(
        cardName: 'Pixel Corp',
        designation: 'UI/UX Designer',
        imageUrl: 'https://via.placeholder.com/150/FF0000',
      ),
      CardModel(
        cardName: 'CodeWave Inc',
        designation: 'Product Manager',
        imageUrl: 'https://via.placeholder.com/150/00FF00',
      ),
    ];

    final selectedCard = useState<CardModel>(dummyCards.first);

    return GestureDetector(
      onTap: () => _showCardSelectionModal(context, dummyCards, selectedCard),
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
              backgroundImage: NetworkImage(selectedCard.value.imageUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedCard.value.cardName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    selectedCard.value.designation,
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
    List<CardModel> cards,
    ValueNotifier<CardModel> selectedCard,
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
                backgroundImage: NetworkImage(card.imageUrl),
              ),
              title: Text(
                card.cardName,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              subtitle: Text(card.designation),
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


class CardModel {
  final String cardName;
  final String designation;
  final String imageUrl;

  CardModel({
    required this.cardName,
    required this.designation,
    required this.imageUrl,
  });
}
