import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_cards/data/model/admin_card_model.dart';
import 'package:wond3rcard/src/admin/admin_cards/data/repository/admin_card_repository.dart';


final cardControllerProvider =
    StateNotifierProvider<CardController, AsyncValue<List<CardModel>>>(
  (ref) => CardController(ref.read(cardRepositoryProvider)),
);

class CardController extends StateNotifier<AsyncValue<List<CardModel>>> {
  final CardRepository _repository;

  CardController(this._repository) : super(const AsyncValue.loading()) {
    fetchCards();
  }

  Future<void> fetchCards() async {
    try {
      final cards = await _repository.fetchCards();
      state = AsyncValue.data(cards);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
