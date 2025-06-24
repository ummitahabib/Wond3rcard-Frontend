import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';

class TestimoniesWidget extends HookConsumerWidget {
  const TestimoniesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.read(cardProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await cardController.getAllUsersCard();
      });
      return null;
    }, []);

    final cards = cardController.getCardsResponse?.payload?.cards ?? [];

    return Container(
      margin: const EdgeInsets.all(12),
      width: 392,
      height: 440,
      padding: const EdgeInsets.all(20),
      decoration: cards.any((card) =>
          card.testimonials != null && card.testimonials!.isNotEmpty)
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cards.any((card) =>
                  card.testimonials != null && card.testimonials!.isNotEmpty)
              ? const Text(
                  'Testimonies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: cards.map((card) {
                  final testimonial = card.testimonials;
                  if (testimonial == null || testimonial.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 80,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(ImageAssets.bgBlur),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          testimonial.join('\n'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
