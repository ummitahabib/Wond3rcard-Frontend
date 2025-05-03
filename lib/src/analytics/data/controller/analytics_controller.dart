import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/data/model/get_analytics_response.dart';
import 'package:wond3rcard/src/analytics/data/model/interaction_request.dart';
import 'package:wond3rcard/src/analytics/data/repository/analytics_repository.dart';
import 'package:wond3rcard/src/cards/data/model/get_a_card.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final analyticsProvider = ChangeNotifierProvider<AnalyticsNotifier>((ref) {
  return AnalyticsNotifier(ref);
});

class AnalyticsNotifier extends ChangeNotifier {
  final Ref ref;

  AnalyticsNotifier(this.ref);

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }

  AnalyticsResponse? _analytics;
  AnalyticsResponse? get analytics => _analytics;

  set analytics(AnalyticsResponse? anal) {
    _analytics = anal;
    notifyListeners();
  }

  GetCardsResponse? _getCards;
  GetCardsResponse? get getCards => _getCards;

  set getCards(GetCardsResponse? card) {
    _getCards = card;
    notifyListeners();
  }

  List<AnalyticsResponse> _analyticsModel = [];

  List<AnalyticsResponse> get analyticsModel => _analyticsModel;

  set analyticsModel(List<AnalyticsResponse> analyticList) {
    _analyticsModel = analyticList;
    notifyListeners();
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  Future<bool> createInteract() async {
    try {
      loading = true;
      final InteractionRequest interactionRequest = InteractionRequest(
        cardId: getCards?.id ?? emptyString,
        cardOwnerId: getCards?.ownerId ?? emptyString,
        interactionType: '',
        ipAddress: '',
      );
      final response = await ref
          .read(analyticsRepoRepository)
          .createInteract(interactionRequest.toJson());
      loading = false;
      if (response.hasError()) {
        if (kDebugMode) {
          print('Error: ${response.error?.message ?? emptyString}');
        }
      } else {
        if (kDebugMode) {
          print('User interacted successfully');
        }
        return true;
      }
    } catch (e) {
      loading = false;
      if (kDebugMode) {
        print('Exception: $e');
      }
    }
    return false;
  }

  Future<AnalyticsResponse?> getInteraction() async {
    try {
      loading = true;
      final response = await ref.read(analyticsRepoRepository).getIntaraction();
      loading = false;
      if (response.hasError()) {
        if (kDebugMode) {
          print('Error: ${response.error?.message ?? emptyString}');
        }
      } else {
        analytics = response.response ?? [];
        return analytics;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      loading = false;
    }
    return null;
  }
}
