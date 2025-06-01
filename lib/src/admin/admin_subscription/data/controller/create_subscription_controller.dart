import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_get_subscription_model.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_subscription_model.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/update_subscription_model.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/repository/create_subscription_repository.dart';
import 'package:wond3rcard/src/subscription/views/widgets/price_plan_section.dart';

final subscriptionRepositoryProvider =
    Provider((ref) => CreateSubscriptionRepository());

final createSubscriptionProvider = StateNotifierProvider<
    CreateSubscriptionNotifier, AsyncValue<Subscription?>>(
  (ref) => CreateSubscriptionNotifier(ref.read(subscriptionRepositoryProvider)),
);

class CreateSubscriptionNotifier
    extends StateNotifier<AsyncValue<Subscription?>> {
  final CreateSubscriptionRepository _repository;

  CreateSubscriptionNotifier(this._repository)
      : super(const AsyncValue.data(null));

  final monthlyPriceController = TextEditingController();
  final monthlyDurationController = TextEditingController();
  final yearlyPriceController = TextEditingController();
  final yearlyDurationController = TextEditingController();
  final descriptionController = TextEditingController();
  final trialPeriodController = TextEditingController();
  final featuresController = TextEditingController();

  String selectedPlan = "Basic";
  bool autoRenew = true;
  String selectedCurrency = '₦';
  String selectedYearlyCurrency = '₦';

  Future<void> createSubscription(Subscription subscription) async {
    state = const AsyncValue.loading();
    try {
      final createdSubscription =
          await _repository.createSubscription(subscription);
      state = AsyncValue.data(createdSubscription);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final getSubscriptionTiersProvider =
    FutureProvider<List<GetSubscriptionTier>>((ref) async {
  return ref.read(subscriptionRepositoryProvider).getSubscriptionTiers();
});

final editSubscriptionProvider = StateNotifierProvider<EditSubscriptionNotifier,
    AsyncValue<SubscriptionTier?>>(
  (ref) => EditSubscriptionNotifier(ref.read(subscriptionRepositoryProvider)),
);

class EditSubscriptionNotifier
    extends StateNotifier<AsyncValue<SubscriptionTier?>> {
  final CreateSubscriptionRepository _repository;

  EditSubscriptionNotifier(this._repository)
      : super(const AsyncValue.data(null));

  Future<void> updateSubscription(
      String id, SubscriptionTier updatedTier) async {
    state = const AsyncValue.loading();
    try {
      final updatedSubscription =
          await _repository.updateSubscriptionTier(id, updatedTier);
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

  DeleteSubscriptionNotifier(this._repository)
      : super(const AsyncValue.data(null));

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

final subscriptionByIdProvider =
    FutureProvider.family<Subscription, String>((ref, id) async {
  return ref.read(subscriptionRepositoryProvider).getSubscriptionById(id);
});

class SubscriptionController extends ChangeNotifier {
  final CreateSubscriptionRepository _repo;

  SubscriptionController(this._repo);

  List<PricingPlan> _pricingPlans = [];
  List<PricingPlan> get pricingPlans => _pricingPlans;

  // Private fields
  List<GetSubscriptionTier>? _subscriptionTiers;
  GetSubscriptionTier? _subscriptionTier;
  Subscription? _selectedSubscription;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<GetSubscriptionTier>? get subscriptionTiers => _subscriptionTiers;
  GetSubscriptionTier? get subscriptionTier => _subscriptionTier;
  Subscription? get selectedSubscription => _selectedSubscription;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Setters with notifyListeners
  set subscriptionTiers(List<GetSubscriptionTier>? tiers) {
    _subscriptionTiers = tiers;
    notifyListeners();
  }

  set subscriptionTier(GetSubscriptionTier? tier) {
    _subscriptionTier = tier;
    notifyListeners();
  }

  set selectedSubscription(Subscription? subscription) {
    _selectedSubscription = subscription;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  // API methods
  Future<void> fetchSubscriptionTiers() async {
    isLoading = true;
    try {
      subscriptionTiers = await _repo.getSubscriptionTiers();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchSubscriptionById(String id) async {
    isLoading = true;
    try {
      selectedSubscription = await _repo.getSubscriptionById(id);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  String _capitalize(String s) =>
      s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;

  Future<void> loadPricingPlans() async {
    isLoading = true;
    try {
      final tiers = await _repo.getSubscriptionTiers();
      final List<PricingPlan> plans = [];

      for (var tier in tiers) {
        try {
          final subscription = await _repo.getSubscriptionById(tier.id);

          plans.add(PricingPlan(
            title: _capitalize(tier.name),
            monthlyPrice: '\$${subscription.billingCycle.monthly.price}/mo',
            yearlyPrice: '\$${subscription.billingCycle.yearly.price}/yr',
            features: subscription.features,
            isPopular: subscription.name
                .toLowerCase()
                .contains('premium'), // optional rule
          ));
        } catch (e) {
          // Ignore individual failures, or log
          debugPrint('Failed to load subscription for tier ${tier.id}: $e');
        }
      }

      _pricingPlans = plans;
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

final subscriptionControllerProvider =
    ChangeNotifierProvider<SubscriptionController>((ref) {
  final repo = ref.read(subscriptionRepositoryProvider);
  return SubscriptionController(repo);
});
