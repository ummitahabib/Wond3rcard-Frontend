import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/payment/data/model/payment_model.dart';
import 'package:wond3rcard/src/payment/data/repository/payment_repository.dart';

final userPaymentRepositoryProvider =
    Provider((ref) => UserPaymentRepository());

final paymentControllerProvider =
    StateNotifierProvider<PaymentController, AsyncValue<PaymentResponseModel?>>(
  (ref) => PaymentController(ref),
);

class PaymentController
    extends StateNotifier<AsyncValue<PaymentResponseModel?>> {
  final Ref ref;

  PaymentController(this.ref) : super(const AsyncValue.data(null));

  Future<void> makePayment({
    required PaymentRequestModel model,
    required String method, // 'paystack' or 'stripe'
  }) async {
    state = const AsyncValue.loading();

    try {
      final repo = ref.read(userPaymentRepositoryProvider);
      PaymentResponseModel response;

      if (method == 'paystack') {
        response = await repo.payWithPaystack(model);
      } else {
        response = await repo.payWithStripe(model);
      }

      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> verify(String reference) async {
    final repo = ref.read(userPaymentRepositoryProvider);
    return await repo.verifyTransaction(reference);
  }
}
