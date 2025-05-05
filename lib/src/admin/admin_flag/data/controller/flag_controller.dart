import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_flag/data/models/create_flag_request.dart';
import 'package:wond3rcard/src/admin/admin_flag/data/repository/flag_repository.dart';
import 'package:wond3rcard/src/utils/alert.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final flagProvider =
    ChangeNotifierProvider<FlagController>((ref) {
  return FlagController(ref);
});

class FlagController extends ChangeNotifier {
  final Ref ref;

  FlagController(this.ref);

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }

  late CreateFlagRequest _createFlagRequest;

  CreateFlagRequest get createFlagRequest => _createFlagRequest;

  set createFlagRequest(CreateFlagRequest organization) {
    _createFlagRequest = organization;
    notifyListeners();
  }



  List<CreateFlagRequest> _organizations = [];

  List<CreateFlagRequest> get organizations => _organizations;

  set organizations(List<CreateFlagRequest> organizationList) {
    _organizations = organizationList;
    notifyListeners();
  }

  TextEditingController organizationNameController = TextEditingController();

  void clearControllers() {
    organizationNameController.clear();
  }

  Future<bool> createNewFlag() async {
    try {
      loading = true;
      final CreateFlagRequest createFlagRequest =
          CreateFlagRequest(
        name: organizationNameController.text,
      );
      final response = await ref
          .read(flagRepoProvider)
          .createFlag(createFlagRequest.toJson());
      loading = false;
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
      } else {
        alert.showSuccessToast(message: 'Flag Created Successfull');
        clearControllers();
        return true;
      }
    } catch (e) {
      loading = false;
    }
    return false;
  }

  Future<bool> updateFlag(String flagId) async {
    try {
      loading = true;
      final CreateFlagRequest updateFlagRequest =
          CreateFlagRequest(
        name: organizationNameController.text,
      );
      final response = await ref
          .read(flagRepoProvider)
          .updateFlag(updateFlagRequest.toJson(), flagId);
      loading = false;
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
      } else {
        alert.showSuccessToast(message: 'Flag Updated Successfull');
        clearControllers();
        return true;
      }
    } catch (e) {
      loading = false;
    }
    return false;
  }

  Future<void> getAllFlags(BuildContext context) async {
    try {
      loading = true;
      final response =
          await ref.watch(flagRepoProvider).getAllFlags();
      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        loading = false;
      } else {
        _createFlagRequest = response.response;
        createFlagRequest = _createFlagRequest;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<CreateFlagRequest>> getAllUsersFlags() async {
    try {
      loading = true;
      final response =
          await ref.watch(flagRepoProvider).getAllUsersFlags();
      loading = false;

      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        return [];
      } else {
        organizations = response.response ?? [];
        return organizations;
      }
    } catch (e) {
      alert.showErrorToast(message: 'An error occurred');
      loading = false;
      return [];
    }
  }

  Future<List<CreateFlagRequest>> getFlagByTier(
      String userTire) async {
    try {
      loading = true;
      final response = await ref
          .watch(flagRepoProvider)
          .getFlagByTier(userTire);
      loading = false;

      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        return [];
      } else {
        organizations = response.response ?? [];
        return organizations;
      }
    } catch (e) {
      alert.showErrorToast(message: 'An error occurred');
      loading = false;
      return [];
    }
  }


  Future<void> deleteFlag(String? organizationId) async {
    try {
      loading = true;
      final response = await ref
          .read(flagRepoProvider)
          .deleteFlag(organizationId!);
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
        loading = false;
      } else {
        await getAllUsersFlags();
      }
    } catch (e) {}
  }
}
