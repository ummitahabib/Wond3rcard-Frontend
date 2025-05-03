// order_physical_card_controller.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wond3rcard/src/physical_card/data/repository/order_physical_card_repo.dart';

final dioProvider = Provider((ref) => Dio());

final orderPhysicalCardRepositoryProvider = Provider(
  (ref) => OrderPhysicalCardRepository(ref.read(dioProvider)),
);

final orderPhysicalCardControllerProvider =
    StateNotifierProvider<OrderPhysicalCardController, AsyncValue<void>>(
  (ref) => OrderPhysicalCardController(ref),
);

class OrderPhysicalCardController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  OrderPhysicalCardController(this.ref) : super(const AsyncData(null));

  Future<void> createOrderAndPay({
    required String userId,
    required String physicalCardId,
    required String cardTemplateId,
    required int quantity,
    required String region,
    required String address,
    required BuildContext context,
  }) async {
    state = const AsyncLoading();
    try {
      final payload = await ref
          .read(orderPhysicalCardRepositoryProvider)
          .createOrder(
            userId: userId,
            physicalCardId: physicalCardId,
            cardTemplateId: cardTemplateId,
            quantity: quantity,
            region: region,
            address: address,
          );

      final paymentUrl = payload['paymentUrl'] as String;

      if (await canLaunchUrl(Uri.parse(paymentUrl))) {
        await launchUrl(
          Uri.parse(paymentUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw Exception("Unable to launch payment URL");
      }

      state = const AsyncData(null);
    } catch (e, st) {
      debugPrint("Error: $e");
      state = AsyncError(e, st);
    }
  }
}



final userOrderProvider = FutureProvider.family
    .autoDispose<List<Map<String, dynamic>>, String>((ref, userId) async {
  final repo = ref.read(orderPhysicalCardRepositoryProvider);
  return await repo.getOrderByUserId(userId);
});



final orderStatusControllerProvider = StateNotifierProvider.family
    .autoDispose<OrderStatusController, AsyncValue<void>, String>((ref, orderId) {
  final repo = ref.watch(orderPhysicalCardRepositoryProvider);
  return OrderStatusController(repo, orderId);
});

class OrderStatusController extends StateNotifier<AsyncValue<void>> {
  final OrderPhysicalCardRepository repo;
  final String orderId;

  OrderStatusController(this.repo, this.orderId) : super(const AsyncData(null));

  Future<void> updateStatus(String status) async {
    state = const AsyncLoading();
    try {
      await repo.updateOrderStatus(orderId: orderId, status: status);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}