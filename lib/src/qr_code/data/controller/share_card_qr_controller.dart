import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/qr_code/data/repository/share_card_via_qr_repository.dart';

final shareCardQrControllerProvider = StateNotifierProvider<ShareCardQrController, AsyncValue<String>>((ref) {
  return ShareCardQrController(ref.watch(shareCardQrRepositoryProvider));
});

class ShareCardQrController extends StateNotifier<AsyncValue<String>> {
  final ShareCardQrRepository _repository;

  ShareCardQrController(this._repository) : super(const AsyncValue.loading());

  Future<void> getQrCode(String cardId) async {
    state = const AsyncValue.loading();
    try {
      final qrCode = await _repository.fetchQrCode(cardId);
      state = AsyncValue.data(qrCode);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
