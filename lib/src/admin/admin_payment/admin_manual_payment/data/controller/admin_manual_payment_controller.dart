import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/model/admin_manual_payment_model.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/model/get_all_transaction_record.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/model/get_manual_transaction.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/model/payment_analytics_model.dart';
import 'package:wond3rcard/src/admin/admin_payment/admin_manual_payment/data/repository/admin_manual_payment_repository.dart';

// Repository Provider
final paymentRepositoryProvider = Provider((ref) => PaymentRepository());

// Manual Payment State Provider
final manualPaymentProvider = StateNotifierProvider<ManualPaymentNotifier, AsyncValue<ManualPaymentResponse?>>(
  (ref) => ManualPaymentNotifier(ref.read(paymentRepositoryProvider)),
);

class ManualPaymentNotifier extends StateNotifier<AsyncValue<ManualPaymentResponse?>> {
  final PaymentRepository _repository;

  ManualPaymentNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> createManualPayment(ManualPaymentRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await _repository.createManualPayment(request);
      state = AsyncValue.data(response);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}




// Transactions State Provider
final transactionsProvider = StateNotifierProvider<TransactionNotifier, AsyncValue<List<Transaction>>>(
  (ref) => TransactionNotifier(ref.read(paymentRepositoryProvider)),
);

class TransactionNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  final PaymentRepository _repository;

  TransactionNotifier(this._repository) : super(const AsyncValue.loading());

  // Fetch transactions by provider
  Future<void> getTransactions(String provider) async {
    state = const AsyncValue.loading();
    try {
      final transactions = await _repository.getTransactionsByProvider(provider);
      state = AsyncValue.data(transactions);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}







// Transactions State Provider
final transactionsRecordProvider = StateNotifierProvider<TransactionRecordNotifier, AsyncValue<List<TransactionRecord>>>(
  (ref) => TransactionRecordNotifier(ref.read(paymentRepositoryProvider)),
);

class TransactionRecordNotifier extends StateNotifier<AsyncValue<List<TransactionRecord>>> {
  final PaymentRepository _repository;

  TransactionRecordNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> getTransactions({
    String? provider,
    String? status,
    String? plan,
    String? billingCycle,
    String? paymentMethod,
    String? transactionId,
    String? referenceId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    state = const AsyncValue.loading();
    try {
      final transactions = await _repository.getTransactions(
        provider: provider,
        status: status,
        plan: plan,
        billingCycle: billingCycle,
        paymentMethod: paymentMethod,
        transactionId: transactionId,
        referenceId: referenceId,
        startDate: startDate,
        endDate: endDate,
      );
      state = AsyncValue.data(transactions);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}






// State Provider
final paymentAnalyticsProvider = StateNotifierProvider<PaymentAnalyticsNotifier, AsyncValue<PaymentAnalytics>>(
  (ref) => PaymentAnalyticsNotifier(ref.read(paymentRepositoryProvider)),
);

class PaymentAnalyticsNotifier extends StateNotifier<AsyncValue<PaymentAnalytics>> {
  final PaymentRepository _repository;

  PaymentAnalyticsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchPaymentAnalytics();
  }

  Future<void> fetchPaymentAnalytics() async {
    try {
      final analytics = await _repository.getPaymentAnalytics();
      state = AsyncValue.data(analytics);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
