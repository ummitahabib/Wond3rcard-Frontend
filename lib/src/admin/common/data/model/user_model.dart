// //temporary model will e removed

// class ProfileModel {
//   UserModel? user;
//   List<String>? perks;

//   ProfileModel.fromJson({required Map<String, dynamic> profileData}) {
//     user = UserModel.fromJson(userData: profileData["user"]);
//     final List<dynamic> perkData = profileData["perks"];
//     perks = perkData.map((e) => e.toString()).toList();
//   }

//   @override
//   String toString() {
//     return {"user": user, "perks": perks}.toString();
//   }
// }

// class UserModel {
//   String? id, firstName, lastName, phone, email, userName;
//   Role? role;
//   DateTime createdAt = DateTime.now();
//   bool? isCarbonPersonnel;

//   UserModel.fromJson({required Map<String, dynamic> userData}) {
//     id = userData["id"];
//     firstName = userData["firstName"];
//     lastName = userData["lastName"];
//     phone = userData["phone"];
//     email = userData["email"];
//     userName = userData["userName"] ?? "";
//     isCarbonPersonnel = userData["carbonPersonnel"] ?? false;
//     role = Role.fromJson(
//       roleData: userData["role"],
//     );
//     createdAt = DateTime.parse(userData["createdAt"]);
//   }

//   @override
//   String toString() {
//     return {
//       "id": id,
//       "firstName": firstName,
//       "lastName": lastName,
//       "phone": phone,
//       "email": email,
//       "carbonPersonnel": isCarbonPersonnel,
//       "role": role,
//       "userName": userName,
//       "createdAt": createdAt,
//     }.toString();
//   }
// }

// class Role {
//   String? id, role;
//   Subscription? subscription;

//   Role.fromJson({required Map<String, dynamic> roleData}) {
//     id = roleData["id"];
//     role = roleData["role"];
//     subscription = Subscription.fromJson(
//       subscriptionData: roleData["subscription"],
//     );
//   }

//   @override
//   String toString() {
//     return {"id": id, "subscription": subscription, "role": role}.toString();
//   }
// }

// class Subscription {
//   String? id;
//   ExpirationDate? expirationDate;
//   List<Permissions> permissions = [];

//   Subscription.fromJson({required Map<String, dynamic> subscriptionData}) {
//     id = subscriptionData["id"];
//     expirationDate = ExpirationDate.fromJson(
//       expirationData: subscriptionData["expirationDate"],
//     );
//     final List<dynamic> permissionData = subscriptionData['permissions'];
//     permissions = permissionData
//         .map(
//           (e) => Permissions.fromJson(
//             permissionData: e,
//           ),
//         )
//         .toList();
//   }

//   @override
//   String toString() {
//     final Map<String, dynamic> data = {
//       "id": id,
//       "expirationDate": expirationDate,
//       "permissions": permissions,
//     };
//     return data.toString();
//   }
// }

// class ExpirationDate {
//   String? smatStar, smatMapper, smatAi, smatSat;

//   ExpirationDate.fromJson({required Map<String, dynamic> expirationData}) {
//     smatStar = expirationData["smatStar"];
//     smatMapper = expirationData["smatMapper"];
//     smatAi = expirationData["smatAi"];
//     smatSat = expirationData["smatSat"];
//   }

//   @override
//   String toString() {
//     final Map<String, dynamic> data = {
//       "smatStar": smatStar,
//       "smatMapper": smatMapper,
//       "smatAi": smatAi,
//       "smatSat": smatSat,
//     };
//     return data.toString();
//   }
// }

// class Permissions {
//   String? name, title;

//   Permissions.fromJson({required Map<String, dynamic> permissionData}) {
//     name = permissionData["name"];
//     title = permissionData["title"];
//   }

//   @override
//   String toString() {
//     final Map<String, dynamic> data = {"name": name, "title": title};
//     return data.toString();
//   }
// }
