import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wond3rcard/src/admin/admin_user_management/data/model/user/user_model.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/utils/util.dart';

// class UserRepository {
//   Future<List<UserModel>> fetchUsers() async {
    
        //  final String token = SessionString.accessTokenString;
    // final response = await http.get(
    //    headers: {
    //       'Content-Type': 'application/json',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $token',
    //     },
    //   Uri.parse(getUrl(Endpoints.allUser),));

//    if (response.statusCode == 200) {
//       final Map<String, dynamic> decodedData = json.decode(response.body);

//       final List<dynamic>? nestedList = decodedData['payload'];

//       if (nestedList == null || nestedList.isEmpty || nestedList[0] is! List) {
//         throw Exception('Invalid data format: Expected a list inside payload');
//       }

//       final List<dynamic> usersJson = nestedList[0]; // Extract the first inner list
//       return UserModel.fromJsonList(usersJson);
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
// }






class UserRepository {

  Future<List<User>> fetchUsers() async {
             final String token = SessionString.accessTokenString;
    try {
        final response = await http.get(
       headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      Uri.parse(getUrl(Endpoints.allUser),));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          return User.fromPayload(data['payload']);
        } else {
          throw Exception("Failed to fetch users: ${data['message']}");
        }
      } else {
        throw Exception("Error fetching users: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
