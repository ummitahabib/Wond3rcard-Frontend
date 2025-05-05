
import 'package:dio/dio.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/organization/data/model/add_member_model.dart';
import 'package:wond3rcard/src/organization/data/model/add_team_member_role.dart';
import 'package:wond3rcard/src/organization/data/model/assign_role_model.dart';
import 'package:wond3rcard/src/organization/data/model/change_role_model.dart';
import 'package:wond3rcard/src/organization/data/model/create_organization_request.dart';
import 'package:wond3rcard/src/organization/data/model/create_organization_response.dart';
import 'package:wond3rcard/src/organization/data/model/create_team_model.dart';
import 'package:wond3rcard/src/organization/data/model/get_team_members_model.dart';
import 'package:wond3rcard/src/organization/data/model/get_user_organization.dart';
import 'package:wond3rcard/src/organization/data/model/remove_member_model.dart';
import 'package:wond3rcard/src/organization/data/model/remove_team_member_model.dart';
import 'package:wond3rcard/src/organization/data/model/update_organization_request.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';

class OrganizationRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl));

  Future<CreateOrganizationResponse> createOrganization(CreateOrganizationRequest request) async {
    try {

          final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
      final response = await _dio.post('organizations/create', data: request.toJson(),
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 201) {
        return CreateOrganizationResponse.fromJson(response.data['payload']);
      } else {
        throw Exception("Failed to create organization");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }




    Future<List<GetUserOrganization>> fetchUserOrganizations() async {
        final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final response = await _dio.get('organizations/user-organizations', 
      
     options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> payload = response.data['payload'];
        return payload.map((json) => GetUserOrganization.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch organizations");
      }
    } catch (e) {
      throw Exception("Error fetching organizations: $e");
    }
  }


    Future<Organization> addMemberToOrganization({
    required String orgId,
    required AddMemberRequest request,
  }) async {
    try {
        final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
      final response = await _dio.post(
        'organizations/$orgId/add-member',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Organization.fromJson(response.data['payload']);
      } else {
        throw Exception("Failed to add member");
      }
    } catch (e) {
      throw Exception("Error adding member: $e");
    }
  }


   Future<UpdateOrganizationResponse> updateOrganization({
    required String orgId,
    required UpdateOrganizationRequest request,
  }) async {
    try {
      final response = await _dio.patch(
        '/organizations/$orgId/update',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return UpdateOrganizationResponse.fromJson(response.data['payload']);
      } else {
        throw Exception("Failed to update organization");
      }
    } catch (e) {
      throw Exception("Error updating organization: $e");
    }
  }


   Future<void> deleteOrganization(String orgId) async {
    try {
      final response = await _dio.delete('/api/organizations/$orgId');

      if (response.statusCode == 200) {
        return; // Successful deletion
      } else {
        throw Exception("Failed to delete organization");
      }
    } catch (e) {
      throw Exception("Error deleting organization: $e");
    }
  }


    Future<Organization> removeMember({
    required String orgId,
    required String memberId,
  }) async {
    try {
      final response = await _dio.patch(
        '/api/organizations/$orgId/remove-member',
        data: RemoveMemberRequest(memberId: memberId).toJson(),
      );
      return Organization.fromJson(response.data['payload']);
    } catch (e) {
      throw Exception('Failed to remove member: $e');
    }
  }



    Future<OrganizationModel> changeMemberRole({
    required String orgId,
    required String memberId,
    required MemberRoleEnum newRole,
  }) async {
    try {
      final response = await _dio.patch(
        '/api/organizations/$orgId/change-role',
        data: ChangeRoleRequest(memberId: memberId, newRole: newRole).toJson(),
      );
      return OrganizationModel.fromJson(response.data['payload']);
    } catch (e) {
      throw Exception('Failed to change member role: $e');
    }
  }


    Future<TeamModel> createTeam({
    required String orgId,
    required CreateTeamRequest request,
  }) async {
    try {
      final response = await _dio.post(
        '/api/organizations/$orgId/teams',
        data: request.toJson(),
      );
      return TeamModel.fromJson(response.data['payload']);
    } catch (e) {
      throw Exception('Failed to create team: $e');
    }
  }


   Future<Team> addMemberToTeam({
    required String orgId,
    required String teamId,
    required AddTeamMemberRequest request,
  }) async {
    try {
      final response = await _dio.post(
        '/api/organizations/$orgId/teams/$teamId/members',
        data: request.toJson(),
      );
      return Team.fromJson(response.data['payload']);
    } catch (e) {
      throw Exception('Failed to add member: $e');
    }
  }



    Future<GetTeamMembers> getTeamMembers({
    required String orgId,
    required String teamId,
  }) async {
    try {
      final response =
          await _dio.get('/api/organizations/$orgId/teams/$teamId/members');
      return GetTeamMembers.fromJson(response.data['payload']);
    } catch (e) {
      throw Exception('Failed to fetch team members: $e');
    }
  }


  Future<AssignRoleResponse> assignRole({
    required String orgId,
    required String teamId,
    required String memberId,
    required TeamRole role,
  }) async {
    try {
      final response = await _dio.patch(
        '/api/organizations/$orgId/teams/$teamId/assign-role',
        data: {
          'memberId': memberId,
          'role': role.name, 
        },
      );
      return AssignRoleResponse.fromJson(response.data['payload']);
    } catch (e) {
      throw Exception('Failed to assign role: $e');
    }
  }

    Future<RemoveTeamMemberResponse> removeTeamMember({
    required String orgId,
    required String teamId,
    required String memberId,
  }) async {
    try {
      final response = await _dio.delete(
        '/api/organizations/$orgId/teams/$teamId/members',
        data: {'memberId': memberId},
      );
      return RemoveTeamMemberResponse.fromJson(response.data['payload']);
    } catch (e) {
      throw Exception('Failed to remove team member: $e');
    }
  }

}








