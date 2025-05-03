import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/repository/custom_physical_card_repository.dart';



final customPhysicalCardRepositoryProvider =
    Provider((ref) => CustomPhysicalCardRepository());



final customPhysicalCardControllerProvider =
    StateNotifierProvider<CustomPhysicalCardController, AsyncValue<String>>(
  (ref) => CustomPhysicalCardController(ref),
);


class CustomPhysicalCardController extends StateNotifier<AsyncValue<String>> {
  final Ref ref;

  CustomPhysicalCardController(this.ref) : super(const AsyncData(''));

  Future<void> createCard({
    required String userId,
    required String cardId,
    required String templateId,
    required String primaryColor,
    required String secondaryColor,
    required PlatformFile platformFile,
  }) async {
    state = const AsyncLoading();
    try {
      await ref.read(customPhysicalCardRepositoryProvider)
          .createCustomPhysicalCard(
        userId: userId,
        cardId: cardId,
        templateId: templateId,
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        platformFile: platformFile,
      );
      state = const AsyncData('Success');
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }




  Future<void> updateCustomCard({
    required String cardId,
    required String primaryColor,
    required String secondaryColor,
    required PlatformFile platformFile,
  }) async {
    state = const AsyncLoading();
    try {
      await ref.read(customPhysicalCardRepositoryProvider)
          .updateCustomPhysicalCard(
        cardId: cardId,
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        platformFile: platformFile,
      );
      state = const AsyncData('Success');
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

}
