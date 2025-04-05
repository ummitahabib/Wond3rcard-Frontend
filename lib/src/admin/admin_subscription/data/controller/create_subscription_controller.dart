import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_get_subscription_model.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_subscription_model.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/update_subscription_model.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/repository/create_subscription_repository.dart';

final subscriptionRepositoryProvider = Provider((ref) => CreateSubscriptionRepository());

final createSubscriptionProvider = StateNotifierProvider<CreateSubscriptionNotifier, AsyncValue<Subscription?>>(
  (ref) => CreateSubscriptionNotifier(ref.read(subscriptionRepositoryProvider)),
);

class CreateSubscriptionNotifier extends StateNotifier<AsyncValue<Subscription?>> {
  final CreateSubscriptionRepository _repository;

  CreateSubscriptionNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> createSubscription(Subscription subscription) async {
    state = const AsyncValue.loading();
    try {
      final createdSubscription = await _repository.createSubscription(subscription);
      state = AsyncValue.data(createdSubscription);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}



final getSubscriptionTiersProvider = FutureProvider<List<GetSubscriptionTier>>((ref) async {
  return ref.read(subscriptionRepositoryProvider).getSubscriptionTiers();
});





// Edit Subscription Provider
final editSubscriptionProvider =
    StateNotifierProvider<EditSubscriptionNotifier, AsyncValue<SubscriptionTier?>>(
  (ref) => EditSubscriptionNotifier(ref.read(subscriptionRepositoryProvider)),
);

class EditSubscriptionNotifier extends StateNotifier<AsyncValue<SubscriptionTier?>> {
  final CreateSubscriptionRepository _repository;

  EditSubscriptionNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> updateSubscription(String id, SubscriptionTier updatedTier) async {
    state = const AsyncValue.loading();
    try {
      final updatedSubscription = await _repository.updateSubscriptionTier(id, updatedTier);
      state = AsyncValue.data(updatedSubscription);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}



final deleteSubscriptionProvider =
    StateNotifierProvider<DeleteSubscriptionNotifier, AsyncValue<void>>(
  (ref) => DeleteSubscriptionNotifier(ref.read(subscriptionRepositoryProvider)),
);

class DeleteSubscriptionNotifier extends StateNotifier<AsyncValue<void>> {
  final CreateSubscriptionRepository _repository;

  DeleteSubscriptionNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> deleteSubscription(String id, String newTierId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteSubscriptionTier(id, newTierId);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  }


final subscriptionByIdProvider = FutureProvider.family<Subscription, String>((ref, id) async {
  return ref.read(subscriptionRepositoryProvider).getSubscriptionById(id);
});