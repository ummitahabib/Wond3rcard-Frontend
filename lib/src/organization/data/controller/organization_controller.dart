import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/model/card_model.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/organization_info.dart';
import 'package:wond3rcard/src/organization/data/model/create_organization_request.dart';
import 'package:wond3rcard/src/organization/data/repository/organization_repository.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/alert.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final organizationProvider =
    ChangeNotifierProvider<OrganizationController>((ref) {
  return OrganizationController(ref);
});

class OrganizationController extends ChangeNotifier {
  final Ref ref;

  OrganizationController(this.ref);

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }

  late CreateOrganizationRequest _organizationModel;

  CreateOrganizationRequest get organizationModel => _organizationModel;

  set organizationModel(CreateOrganizationRequest organization) {
    _organizationModel = organization;
    notifyListeners();
  }

  late OrganizationInfo _organizationInfo;

  OrganizationInfo get organizationInfo => _organizationInfo;

  set organizationInfo(OrganizationInfo organization) {
    _organizationInfo = organization;
    notifyListeners();
  }

  List<CreateOrganizationRequest> _organizations = [];

  List<CreateOrganizationRequest> get organizations => _organizations;

  set organizations(List<CreateOrganizationRequest> organizationList) {
    _organizations = organizationList;
    notifyListeners();
  }

  TextEditingController organizationNameController = TextEditingController();

  void clearControllers() {
    organizationNameController.clear();
  }

  Future<bool> createNewOrganization() async {
    try {
      loading = true;
      final CreateOrganizationRequest createOrganizationRequest =
          CreateOrganizationRequest(
        name: organizationNameController.text,
      );
      final response = await ref
          .read(organizationRepoProvider)
          .createOrganization(createOrganizationRequest.toJson());
      loading = false;
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
      } else {
        alert.showSuccessToast(message: 'Organization Created Successfull');
        clearControllers();
        return true;
      }
    } catch (e) {
      loading = false;
    }
    return false;
  }

  Future<bool> updateOrganization() async {
    try {
      loading = true;
      final CreateOrganizationRequest updateOrganizationRequest =
          CreateOrganizationRequest(
        name: organizationNameController.text,
      );
      final response = await ref
          .read(organizationRepoProvider)
          .createOrganization(updateOrganizationRequest.toJson());
      loading = false;
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
      } else {
        alert.showSuccessToast(message: 'Organization Updated Successfull');
        clearControllers();
        return true;
      }
    } catch (e) {
      loading = false;
    }
    return false;
  }

  Future<void> getUserOrganization(BuildContext context) async {
    try {
      loading = true;
      final response =
          await ref.watch(organizationRepoProvider).getUserOrganization();
      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        loading = false;
      } else {
        _organizationModel = response.response;
        organizationModel = _organizationModel;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<CreateOrganizationRequest>> getAllUsersOrganization() async {
    try {
      loading = true;
      final response =
          await ref.watch(organizationRepoProvider).getAllUsersOrganizations();
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

  Future<bool> addMemberToOrganization(
      CreateOrganizationRequest request) async {
    try {
      loading = true;
      final response = await ref
          .watch(organizationRepoProvider)
          .addMemberToOrganization(request);
      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
      } else {
        getAllUsersOrganization();
        alert.showSuccessToast(
          message: 'organization created',
        );
        return true;
      }
    } catch (e) {
      alert.showErrorToast(message: 'error occured');
    }
    return false;
  }

  Future<List<CreateOrganizationRequest>> getUsersByOrganizationId(
      String organizationId) async {
    try {
      loading = true;
      final response = await ref
          .watch(organizationRepoProvider)
          .getUsersByOrganizationId(organizationId);
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

  Future<bool> changeOrganizationMemberRole() async {
    // id of the user needed here
    String memberId = '';
    //String organizationId = organizationInfo.organizationId ?? emptyString;
    final String role =
        ref.watch(profileProvider).profileData?.payload.user.userRole ??
            emptyString;

    Map<String, dynamic> request = {
      "memberId": memberId,
      "organizationId": '',
      // organizationId,
      "role": role,
    };
    try {
      loading = true;
      final response = await ref
          .watch(organizationRepoProvider)
          .changeOrganizationMemberRole(request);
      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
      } else {
        getAllUsersOrganization();
        alert.showSuccessToast(
          message: 'organization created',
        );
        return true;
      }
    } catch (e) {
      alert.showErrorToast(message: 'error occured');
    }
    return false;
  }

  Future<void> deleteOrganization(String? organizationId) async {
    try {
      loading = true;
      final response = await ref
          .read(organizationRepoProvider)
          .deleteOrganizationById(organizationId!);
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
        loading = false;
      } else {
        await getAllUsersOrganization();
      }
    } catch (e) {}
  }
}
