
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/model/physical_card_template_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/physical_card/data/repository/physical_card_template.dart';





final cardTemplateRepositoryProvider = Provider((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://wond3rcard-backend.onrender.com/api/'));

  return CardTemplateRepository(dio);
});


final cardTemplateControllerProvider =
    StateNotifierProvider<CardTemplateController, AsyncValue<CardTemplateModel?>>(
  (ref) => CardTemplateController(ref),
);

class CardTemplateController extends StateNotifier<AsyncValue<CardTemplateModel?>> {
  final Ref ref;

  CardTemplateController(this.ref) : super(const AsyncData(null));

  Future<void> createCardTemplate({
    required String name,
    required String priceNaira,
    required String priceUsd,
    required PlatformFile file,
  }) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(cardTemplateRepositoryProvider);

      final template = await repository.createTemplate(
        name: name,
        priceNaira: priceNaira,
        priceUsd: priceUsd,
        file: file,
      );

      state = AsyncData(template);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }




  
}



final cardTemplateListControllerProvider = StateNotifierProvider<CardTemplateListController, AsyncValue<List<CardTemplateModel>>>(
  (ref) => CardTemplateListController(ref),
);

class CardTemplateListController extends StateNotifier<AsyncValue<List<CardTemplateModel>>> {
  final Ref ref;

  CardTemplateListController(this.ref) : super(const AsyncLoading()) {
    getAllTemplates(); // fetch when controller is initialized
  }

  Future<void> getAllTemplates() async {
    try {
      final repository = ref.read(cardTemplateRepositoryProvider);
      final templates = await repository.getAllTemplates();
      state = AsyncData(templates);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}


final singleTemplateProvider = FutureProvider.family<CardTemplateModel, String>((ref, id) async {
  final repo = ref.read(cardTemplateRepositoryProvider);
  return await repo.getTemplateById(id);
});




final updateTemplateControllerProvider =
    StateNotifierProvider<UpdateTemplateController, AsyncValue<CardTemplateModel?>>(
  (ref) => UpdateTemplateController(ref),
);

class UpdateTemplateController extends StateNotifier<AsyncValue<CardTemplateModel?>> {
  final Ref ref;

  UpdateTemplateController(this.ref) : super(const AsyncData(null));

  Future<void> updateTemplate({
    required String templateId,
    required String priceNaira,
    required String priceUsd,
    PlatformFile? svgFile,
  }) async {
    state = const AsyncLoading();

    try {
      final repo = ref.read(cardTemplateRepositoryProvider);
      final updated = await repo.updateTemplate(
        templateId: templateId,
        priceNaira: priceNaira,
        priceUsd: priceUsd,
        svgFile: svgFile,
      );
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}


final deleteCardTemplateControllerProvider =
    StateNotifierProvider<DeleteCardTemplateController, AsyncValue<String>>(
  (ref) => DeleteCardTemplateController(ref),
);

class DeleteCardTemplateController extends StateNotifier<AsyncValue<String>> {
  final Ref ref;

  DeleteCardTemplateController(this.ref) : super(const AsyncData(''));

  Future<void> deleteCardTemplate({required String templateId}) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(cardTemplateRepositoryProvider);
      final message = await repository.deleteCardTemplate(templateId: templateId);
      state = AsyncData(message);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}


