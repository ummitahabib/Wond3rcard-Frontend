import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/subscription/data/model/subscription_model.dart';
import 'package:wond3rcard/src/subscription/data/repository/subscription_repository.dart';

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  return SubscriptionRepository(baseUrl: 'https://yourapi.com');
});

final subscriptionControllerProvider = StateNotifierProvider<
    SubscriptionController, AsyncValue<SubscriptionResponse>>((ref) {
  final repository = ref.read(subscriptionRepositoryProvider);
  return SubscriptionController(repository);
});

class SubscriptionController
    extends StateNotifier<AsyncValue<SubscriptionResponse>> {
  final SubscriptionRepository repository;

  SubscriptionController(this.repository) : super(const AsyncValue.loading());

  Future<void> initiateSubscription(SubscriptionRequest request) async {
    try {
      state = const AsyncValue.loading();
      final response = await repository.createSubscription(request);
      state = AsyncValue.data(response);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
