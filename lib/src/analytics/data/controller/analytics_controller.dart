import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/data/model/get_analytics_response.dart';
import 'package:wond3rcard/src/analytics/data/model/interaction_request.dart';
import 'package:wond3rcard/src/analytics/data/repository/analytics_repository.dart';
import 'package:wond3rcard/src/utils/alert.dart';
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
        cardId: '',
        cardOwnerId: '',
        // deviceInfo: '',
        interactionType: '',
        // interactor: '',
        ipAddress: '',
      );
      final response = await ref
          .read(analyticsRepoRepository)
          .createInteract(interactionRequest.toJson());
      loading = false;
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
      } else {
        alert.showSuccessToast(message: 'user interacted Successfull');
        return true;
      }
    } catch (e) {
      loading = false;
    }
    return false;
  }

  Future<AnalyticsResponse?> getInteraction() async {
    try {
      loading = true;
      final response = await ref.read(analyticsRepoRepository).getIntaraction();
      loading = false;
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);

        print('this is the get profile error ${response.error?.message}');
      } else {
        analytics = response.response ?? [];
        return analytics;
      }
    } catch (e) {
      print('this is the catch error $e');
      alert.showErrorToast(
        message: 'unableToCompleteProcess',
      );
      loading = false;
      return null;
    }
    return null;
  }
}
