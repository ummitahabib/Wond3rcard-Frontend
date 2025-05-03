import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/cards/data/model/getCard/get_card_model.dart';
import 'package:wond3rcard/src/cards/data/repository/get_card_repository.dart';





final getCardProvider = FutureProvider<GetCardModel?>((ref) async {
  print("🔄 Fetching Card Data...");
  final repository = ref.read(getCardRepositoryProvider);
  return repository.getCard();
});