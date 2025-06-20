import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:wond3rcard/src/cards/data/repository/card_template_repository.dart';
import 'package:wond3rcard/src/physical_card/data/model/physical_card_template_model.dart';

final dioProvider = Provider((ref) => Dio());

final templateRepositoryProvider = Provider(
  (ref) => TemplateRepository(ref.watch(dioProvider)),
);

class CardTemplateController extends StateNotifier<CardTemplateModel?> {
  CardTemplateController() : super(null);

  CardTemplateModel? get cardTemplate => state;

  set cardTemplate(CardTemplateModel? value) {
    state = value;
  }
}

final cardTemplateControllerProvider =
    StateNotifierProvider<CardTemplateController, CardTemplateModel?>(
        (ref) => CardTemplateController());

final templateListProvider =
    FutureProvider<List<CardTemplateModel>>((ref) async {
  final repository = ref.watch(templateRepositoryProvider);
  return repository.getTemplates();
});
