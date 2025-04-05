import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/organization/data/model/add_member_model.dart';
import 'package:wond3rcard/src/organization/data/model/add_members_params.dart';
import 'package:wond3rcard/src/organization/data/model/add_team_member_role.dart';
import 'package:wond3rcard/src/organization/data/model/assign_role_model.dart';
import 'package:wond3rcard/src/organization/data/model/assign_role_params.dart';
import 'package:wond3rcard/src/organization/data/model/change_role_model.dart';
import 'package:wond3rcard/src/organization/data/model/create_organization_request.dart';
import 'package:wond3rcard/src/organization/data/model/create_organization_response.dart';
import 'package:wond3rcard/src/organization/data/model/create_team_model.dart';
import 'package:wond3rcard/src/organization/data/model/get_team_members_model.dart';
import 'package:wond3rcard/src/organization/data/model/get_user_organization.dart';
import 'package:wond3rcard/src/organization/data/model/remove_team_member_model.dart';
import 'package:wond3rcard/src/organization/data/model/remove_team_members_params.dart';
import 'package:wond3rcard/src/organization/data/model/team_params.dart';
import 'package:wond3rcard/src/organization/data/model/update_organization_request.dart';
import 'package:wond3rcard/src/organization/data/repository/organization_repository.dart';

// Repository Provider
final organizationRepositoryProvider = Provider((ref) => OrganizationRepository());

// State Notifier Provider
final createOrganizationProvider = StateNotifierProvider<OrganizationNotifier, AsyncValue<CreateOrganizationResponse?>>(
  (ref) => OrganizationNotifier(ref.read(organizationRepositoryProvider)),
);

class OrganizationNotifier extends StateNotifier<AsyncValue<CreateOrganizationResponse?>> {
  final OrganizationRepository _repository;

  OrganizationNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> createOrganization(CreateOrganizationRequest request) async {
    state = const AsyncValue.loading();
    try {
      final organization = await _repository.createOrganization(request);
      state = AsyncValue.data(organization);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}


final userOrganizationsProvider = FutureProvider<List<GetUserOrganization>>((ref) async {
  final repository = ref.watch(organizationRepositoryProvider);
  return repository.fetchUserOrganizations();
});



// Add Member Notifier
class AddMemberNotifier extends StateNotifier<AsyncValue<Organization?>> {
  final OrganizationRepository repository;

  AddMemberNotifier(this.repository) : super(const AsyncValue.data(null));

  Future<void> addMember({
    required String orgId,
    required AddMemberRequest request,
  }) async {
    state = const AsyncValue.loading();
    try {
      final updatedOrg = await repository.addMemberToOrganization(
        orgId: orgId,
        request: request,
      );
      state = AsyncValue.data(updatedOrg);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

// Provide the Add Member Notifier
final addMemberProvider =
    StateNotifierProvider<AddMemberNotifier, AsyncValue<Organization?>>(
  (ref) => AddMemberNotifier(ref.watch(organizationRepositoryProvider)),
);





class UpdateOrganizationNotifier
    extends StateNotifier<AsyncValue<UpdateOrganizationResponse?>> {
  final OrganizationRepository repository;

  UpdateOrganizationNotifier(this.repository) : super(const AsyncValue.data(null));

  // Update organization
  Future<void> updateOrganization({
    required String orgId,
    required UpdateOrganizationRequest request,
  }) async {
    state = const AsyncValue.loading();
    try {
      final updatedOrganization =
          await repository.updateOrganization(orgId: orgId, request: request);
      state = AsyncValue.data(updatedOrganization);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

// Provider for updating organization
final updateOrganizationProvider = StateNotifierProvider<UpdateOrganizationNotifier, AsyncValue<UpdateOrganizationResponse?>>(
  (ref) => UpdateOrganizationNotifier(ref.watch(organizationRepositoryProvider)),
);




// Notifier to handle delete organization
class DeleteOrganizationNotifier extends StateNotifier<AsyncValue<void>> {
  final OrganizationRepository repository;

  DeleteOrganizationNotifier(this.repository) : super(const AsyncValue.data(null));

  // Method to delete an organization
  Future<void> deleteOrganization(String orgId) async {
    state = const AsyncValue.loading();
    try {
      await repository.deleteOrganization(orgId);
      state = const AsyncValue.data(null); // Success
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // Error
    }
  }
}

// Provider for deleting organization
final deleteOrganizationProvider = StateNotifierProvider<DeleteOrganizationNotifier, AsyncValue<void>>(
  (ref) => DeleteOrganizationNotifier(ref.watch(organizationRepositoryProvider)),
);



final removeMemberProvider = StateNotifierProvider.family<
    RemoveMemberNotifier, AsyncValue<Organization>, String>(
  (ref, orgId) => RemoveMemberNotifier(
    ref.read(organizationRepositoryProvider),
    orgId,
  ),
);

class RemoveMemberNotifier extends StateNotifier<AsyncValue<Organization>> {
  final OrganizationRepository repository;
  final String orgId;

  RemoveMemberNotifier(this.repository, this.orgId)
      : super(const AsyncValue.loading());

  Future<void> removeMember(String memberId) async {
    state = const AsyncValue.loading();
    try {
      final updatedOrg =
          await repository.removeMember(orgId: orgId, memberId: memberId);
      state = AsyncValue.data(updatedOrg);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}



final changeRoleProvider = StateNotifierProvider.family<
    ChangeRoleNotifier, AsyncValue<OrganizationModel>, String>(
  (ref, orgId) => ChangeRoleNotifier(
    ref.read(organizationRepositoryProvider),
    orgId,
  ),
);

class ChangeRoleNotifier extends StateNotifier<AsyncValue<OrganizationModel>> {
  final OrganizationRepository repository;
  final String orgId;

  ChangeRoleNotifier(this.repository, this.orgId)
      : super(const AsyncValue.loading());

  Future<void> changeRole(String memberId, MemberRoleEnum newRole) async {
    state = const AsyncValue.loading();
    try {
      final updatedOrg = await repository.changeMemberRole(
        orgId: orgId,
        memberId: memberId,
        newRole: newRole,
      );
      state = AsyncValue.data(updatedOrg);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final createTeamProvider = StateNotifierProvider.family<CreateTeamNotifier, AsyncValue<TeamModel>, String>(
  (ref, orgId) => CreateTeamNotifier(ref.read(organizationRepositoryProvider), orgId),
);

class CreateTeamNotifier extends StateNotifier<AsyncValue<TeamModel>> {
  final OrganizationRepository repository;
  final String orgId;

  CreateTeamNotifier(this.repository, this.orgId) : super(AsyncValue.data(TeamModel(
    id: '',
    name: '',
    description: '',
    organizationId: '',
    members: [],
    createdAt: DateTime.now(),
  )));

  Future<void> createTeam(CreateTeamRequest request) async {
    state = const AsyncValue.loading();
    try {
      final team = await repository.createTeam(orgId: orgId, request: request);
      state = AsyncValue.data(team);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}


final addMemberToTeamProvider = StateNotifierProvider.family<
    AddMemberToTeamNotifier, AsyncValue<Team>, AddMemberParams>(
  (ref, params) =>
      AddMemberToTeamNotifier(ref.read(organizationRepositoryProvider), params),
);


class AddMemberToTeamNotifier extends StateNotifier<AsyncValue<Team>> {
  final OrganizationRepository repository;
  final AddMemberParams params;

  AddMemberToTeamNotifier(this.repository, this.params)
      : super(AsyncValue.data(Team(
          id: '',
          name: '',
          description: '',
          organizationId: '',
          members: [],
          createdAt: DateTime.now(),
        )));

  Future<void> addMember(AddTeamMemberRequest request) async {
    state = const AsyncValue.loading();
    try {
      final team = await repository.addMemberToTeam(
        orgId: params.orgId,
        teamId: params.teamId,
        request: request,
      );
      state = AsyncValue.data(team);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}





// Fetch team members provider
final teamMembersProvider = FutureProvider.family<GetTeamMembers, TeamParams>(
  (ref, params) async {
    final repository = ref.read(organizationRepositoryProvider);
    return repository.getTeamMembers(
      orgId: params.orgId,
      teamId: params.teamId,
    );
  },
);





final assignRoleProvider = FutureProvider.family.autoDispose<
    AssignRoleResponse, AssignRoleParams>(
  (ref, params) async {
    final repository = ref.read(organizationRepositoryProvider);
    return repository.assignRole(
      orgId: params.orgId,
      teamId: params.teamId,
      memberId: params.memberId,
      role: params.role,
    );
  },
);






// Remove team member provider
final removeTeamMemberProvider = FutureProvider.family.autoDispose<
    RemoveTeamMemberResponse, RemoveTeamMemberParams>(
  (ref, params) async {
    final repository = ref.read(organizationRepositoryProvider);
    return repository.removeTeamMember(
      orgId: params.orgId,
      teamId: params.teamId,
      memberId: params.memberId,
    );
  },
);

