import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/get_card_controller.dart';

class GetCardScreen extends ConsumerWidget {
  const GetCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardData = ref.watch(getCardProvider);

    return Scaffold(
      appBar: AppBar(title: Text("My Business Card")),
      body: cardData.when(
        data: (card) {
          if (card == null) {
            return Center(child: Text("🚨 No card data available"));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: card.cardPictureUrl != null
                      ? Image.network(
                          "${card.cardPictureUrl}",
                          height: 150,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image, size: 100),
                        )
                      : Icon(Icons.image, size: 100),
                ),
                SizedBox(height: 10),
                Text(
                  "Name: ${card.firstName} ${card.lastName}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("Card Type: ${card.cardType}"),
                Text("Phone: ${card.contactInfo.phone}"),
                Text("Email: ${card.contactInfo.email}"),
                Text("Website: ${card.contactInfo.website}"),
                card.cardCoverUrl != null
                    ? Image.network(
                        "${card.cardCoverUrl}",
                        height: 100,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.broken_image, size: 50),
                      )
                    : Container(),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("❌ Error: $error")),
      ),
    );
  }
}
