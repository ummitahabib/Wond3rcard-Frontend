import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/model/physical_card_model.dart';
import 'package:wond3rcard/src/physical_card/data/repository/physical_card_repository.dart';

final physicalCardControllerProvider =
    StateNotifierProvider<PhysicalCardController, AsyncValue<PhysicalCardModel?>>(
  (ref) => PhysicalCardController(ref),
);

class PhysicalCardController extends StateNotifier<AsyncValue<PhysicalCardModel?>> {
  final Ref ref;

  PhysicalCardController(this.ref) : super(const AsyncData(null));

  Future<void> createCard({
    required String userId,
    required String cardId,
    required String templateId,
    required String primaryColor,
    required String secondaryColor,
    required String finalDesign,
  }) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(physicalCardRepositoryProvider);
      final card = await repository.createPhysicalCard(
        userId: userId,
        cardId: cardId,
        templateId: templateId,
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        finalDesign: finalDesign,
      );
      state = AsyncData(card);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}




final physicalCardListControllerProvider = StateNotifierProvider<
    PhysicalCardListController, AsyncValue<List<PhysicalCardModel>>>((ref) {
  return PhysicalCardListController(ref);
});

class PhysicalCardListController
    extends StateNotifier<AsyncValue<List<PhysicalCardModel>>> {
  final Ref ref;

  PhysicalCardListController(this.ref) : super(const AsyncLoading());

  Future<void> getPhysicalCards() async {
    try {
      final cards = await ref.read(physicalCardRepositoryProvider)
          .getPhysicalCards();
      state = AsyncData(cards);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }




    Future<void> getPhysicalCardsByUserId(String userId) async {
    try {
      final cards = await ref.read(physicalCardRepositoryProvider)
          .getPhysicalCards();
      state = AsyncData(cards);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }


    Future<void> getPhysicalCardsByCardId(String cardId) async {
    try {
      final cards = await ref.read(physicalCardRepositoryProvider)
          .getPhysicalCardsByCardId(cardId);
      state = AsyncData(cards);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}







final deletePhysicalCardControllerProvider =
    StateNotifierProvider<DeletehysicalCardController, AsyncValue<String>>(
  (ref) => DeletehysicalCardController(ref),
);

class DeletehysicalCardController extends StateNotifier<AsyncValue<String>> {
  final Ref ref;

  DeletehysicalCardController(this.ref) : super(const AsyncData(''));

  Future<void> deletePhysicalCard({required String cardId}) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(physicalCardRepositoryProvider);
      final message = await repository.deletePhysicalCard(cardId: cardId);
      state = AsyncData(message);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}


