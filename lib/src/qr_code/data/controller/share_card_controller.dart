import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/qr_code/data/repository/share_card_link_repository.dart';
import 'package:wond3rcard/src/qr_code/data/repository/share_card_via_qr_repository.dart';



final shareCardLinkControllerProvider =
    StateNotifierProvider<ShareCardLinkController, AsyncValue<String>>((ref) {
  final repository = ref.watch(shareCardLinkRepositoryProvider);
  return ShareCardLinkController(repository);
});

class ShareCardLinkController extends StateNotifier<AsyncValue<String>> {
  final ShareCardLinkRepository repository;

  ShareCardLinkController(this.repository) : super(const AsyncValue.loading());

  Future<void> getShareableLink(String cardId) async {
    state = const AsyncValue.loading();
    try {
      final shareableLink = await repository.fetchShareableLink(cardId);
      state = AsyncValue.data(shareableLink);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
