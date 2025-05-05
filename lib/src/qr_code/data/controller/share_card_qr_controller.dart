import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/qr_code/data/repository/share_card_via_qr_repository.dart';


final shareCardQrControllerProvider =
    StateNotifierProvider<ShareCardQrController, AsyncValue<String>>((ref) {
  final repository = ref.watch(shareCardQrRepositoryProvider);
  return ShareCardQrController(repository);
});

class ShareCardQrController extends StateNotifier<AsyncValue<String>> {
  final ShareCardQrRepository repository;

  ShareCardQrController(this.repository) : super(const AsyncValue.loading());

  Future<void> getQrCode(String cardId) async {
    state = const AsyncValue.loading();
    try {
      final qrCode = await repository.fetchQrCode(cardId);
      state = AsyncValue.data(qrCode);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
