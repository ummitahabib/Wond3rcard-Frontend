import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_controller.dart';

class PhysicalCardListScreen extends ConsumerStatefulWidget {

  const PhysicalCardListScreen({super.key});

  @override
  ConsumerState<PhysicalCardListScreen> createState() =>
      _PhysicalCardListScreenState();
}

class _PhysicalCardListScreenState
    extends ConsumerState<PhysicalCardListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(physicalCardListControllerProvider.notifier)
        .getPhysicalCards());
  }

  @override
  Widget build(BuildContext context) {
    final cardState = ref.watch(physicalCardListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Physical Cards")),
      body: cardState.when(
        data: (cards) => ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return Card(
              margin: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(card.cardTemplate.name),
                    subtitle: Text("Status: ${card.status}"),
                    trailing: Text("₦${card.cardTemplate.priceNaira}"),
                  ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.string(
                      card.finalDesign,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error loading cards: $e")),
      ),
    );
  }
}
