import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/model/custom_card_model.dart';
import 'package:wond3rcard/src/physical_card/data/repository/custom_card_repository.dart';

final customCardRepositoryProvider = Provider((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://wond3rcard-backend.onrender.com/api/'));
  return CustomCardRepository(dio);
});

final customCardControllerProvider =
    StateNotifierProvider<CustomCardController, AsyncValue<CustomCardModel?>>(
  (ref) => CustomCardController(ref),
);

class CustomCardController extends StateNotifier<AsyncValue<CustomCardModel?>> {
  final Ref ref;

  CustomCardController(this.ref) : super(const AsyncValue.data(null));

  Future<void> createCustomCard({
    required String name,
    required String priceNaira,
    required String priceUsd,
  }) async {
    state = const AsyncLoading();
    try {
      final card = await ref.read(customCardRepositoryProvider).createCustomCard(
            name: name,
            priceNaira: priceNaira,
            priceUsd: priceUsd,
          );
      state = AsyncValue.data(card);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}




final updateCustomCardControllerProvider =
    StateNotifierProvider<UpdateCustomCardController, AsyncValue<CustomCardModel?>>(
  (ref) => UpdateCustomCardController(ref),
);

class UpdateCustomCardController extends StateNotifier<AsyncValue<CustomCardModel?>> {
  final Ref ref;

  UpdateCustomCardController(this.ref) : super(const AsyncData(null));

  Future<void> updateCustomCard({
    required String templateId,
    required String name,
    required String priceNaira,
    required String priceUsd,
  }) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(customCardRepositoryProvider);
      final updated = await repository.updateCustomCard(
        templateId: templateId,
        name: name,
        priceNaira: priceNaira,
        priceUsd: priceUsd,
      );
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
