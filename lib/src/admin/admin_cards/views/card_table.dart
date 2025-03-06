import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_cards/data/controller/admin_card_controller.dart';

import 'package:wond3rcard/src/admin/admin_cards/data/model/admin_card_model.dart';


class CardTableScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardState = ref.watch(cardControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Card List")),
      body: cardState.when(
        data: (cards) {
          if (cards.isEmpty) {
            return Center(child: Text("No cards available."));
          }
          return _buildTable(cards);
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: ${e.toString()}")),
      ),
    );
  }

  Widget _buildTable(List<CardModel> cards) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 800),
        child: DataTable(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
          border: TableBorder.all(color: Colors.grey[300]!),
          columns: const [
            DataColumn(label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Card Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('First Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Last Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: cards.map((card) => _buildDataRow(card)).toList(),
        ),
      ),
    );
  }

  DataRow _buildDataRow(CardModel card) {
    return DataRow(cells: [
      DataCell(Text(card.id ?? 'N/A')),
      DataCell(Text(card.cardName ?? 'N/A')),
      DataCell(Text(card.firstName ?? 'N/A')),
      DataCell(Text(card.lastName ?? 'N/A')),
      DataCell(Text(card.contactInfo?.email ?? 'N/A')),
      DataCell(Text(card.contactInfo?.phone ?? 'N/A')),
    ]);
  }
}
