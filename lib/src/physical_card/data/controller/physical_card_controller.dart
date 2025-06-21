import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/data/model/card_model.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/get_card.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/getcard.dart';
import 'package:wond3rcard/src/physical_card/data/model/physical_card_model.dart';
import 'package:wond3rcard/src/physical_card/data/repository/physical_card_repository.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'dart:developer';

final physicalCardControllerProvider = StateNotifierProvider<
    PhysicalCardController, AsyncValue<PhysicalCardModel?>>(
  (ref) => PhysicalCardController(ref),
);

class PhysicalCardController
    extends StateNotifier<AsyncValue<PhysicalCardModel?>> {
  final Ref ref;

  PhysicalCardController(this.ref) : super(const AsyncData(null));

  Future<void> createCard({
    required String userId,
    required String cardId,
    required String templateId,
    required String primaryColor,
    required String secondaryColor,
    required String finalDesign,
  }) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(physicalCardRepositoryProvider);
      final card = await repository.createPhysicalCard(
        userId: userId,
        cardId: cardId,
        templateId: templateId,
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        finalDesign: finalDesign,
      );
      state = AsyncData(card);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final physicalCardListControllerProvider = StateNotifierProvider<
    PhysicalCardListController, AsyncValue<List<PhysicalCardModel>>>((ref) {
  return PhysicalCardListController(ref);
});

class PhysicalCardListController
    extends StateNotifier<AsyncValue<List<PhysicalCardModel>>> {
  final Ref ref;

  PhysicalCardListController(this.ref) : super(const AsyncLoading());

  Future<void> getPhysicalCards() async {
    try {
      final cards =
          await ref.read(physicalCardRepositoryProvider).getPhysicalCards();
      state = AsyncData(cards);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> getPhysicalCardsByUserId(String userId) async {
    try {
      final cards = await ref
          .read(physicalCardRepositoryProvider)
          .getPhysicalCardsByUserId(userId);
      state = AsyncData(cards);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> getPhysicalCardsByCardId(String cardId) async {
    try {
      final cards = await ref
          .read(physicalCardRepositoryProvider)
          .getPhysicalCardsByCardId(cardId);
      state = AsyncData(cards);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final deletePhysicalCardControllerProvider =
    StateNotifierProvider<DeletehysicalCardController, AsyncValue<String>>(
  (ref) => DeletehysicalCardController(ref),
);

class DeletehysicalCardController extends StateNotifier<AsyncValue<String>> {
  final Ref ref;

  DeletehysicalCardController(this.ref) : super(const AsyncData(''));

  Future<void> deletePhysicalCard({required String cardId}) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(physicalCardRepositoryProvider);
      final message = await repository.deletePhysicalCard(cardId: cardId);
      state = AsyncData(message);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final fullCardListProvider =
    StateNotifierProvider<FullCardListController, AsyncValue<List<GetCard>>>(
        (ref) {
  return FullCardListController(ref);
});

class FullCardListController extends StateNotifier<AsyncValue<List<GetCard>>> {
  final Ref ref;

  FullCardListController(this.ref) : super(const AsyncLoading());
  Future<void> loadCardsForUser(BuildContext context) async {
    try {
      final profileController = ref.read(profileProvider);

      // Fetch user profile and extract userId
      await profileController.getProfile(context);
      final userId = profileController.profileData?.payload.user.id ?? '';

      if (userId.isEmpty) {
        state = const AsyncData([]);
        log('No userId found.');
        return;
      }

      // Fetch physical cards for user
      final physicalCards = await ref
          .read(physicalCardRepositoryProvider)
          .getPhysicalCardsByUserId(userId);

      log('Physical cards: $physicalCards');

      final cardIds = physicalCards
          .map((e) => e.cardId.toString())
          .where((id) => id.isNotEmpty)
          .toList();

      final cardRepo = ref.read(cardProvider);
      final List<GetCard> detailedCards = [];

      // Refactored: Remove BuildContext from getAUsersCard
      for (final cardId in cardIds) {
        final card = await cardRepo.getAUsersCard(context, cardId);
        if (card != null) {
          detailedCards.add(card);
        }
      }

      log('Detailed cards: $detailedCards');
      state = AsyncData(detailedCards);
    } catch (e, st) {
      log('Error loading cards: $e');
      state = AsyncError(e, st);
    }
  }
}
