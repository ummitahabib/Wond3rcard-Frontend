// import 'dart:convert';

// import 'package:collection/collection.dart';

// import 'payload.dart';

// class GetCard {
//   int? statusCode;
//   String? status;
//   String? message;
//   Payload? payload;

//   GetCard({this.statusCode, this.status, this.message, this.payload});

//   @override
//   String toString() {
//     return 'GetCard(statusCode: $statusCode, status: $status, message: $message, payload: $payload)';
//   }

//   factory GetCard.fromMap(Map<String, dynamic> data) => GetCard(
//         statusCode: data['statusCode'] as int?,
//         status: data['status'] as String?,
//         message: data['message'] as String?,
//         payload: data['payload'] == null
//             ? null
//             : Payload.fromMap(data['payload'] as Map<String, dynamic>),
//       );

//   Map<String, dynamic> toMap() => {
//         'statusCode': statusCode,
//         'status': status,
//         'message': message,
//         'payload': payload?.toMap(),
//       };

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object as [GetCard].
//   factory GetCard.fromJson(String data) {
//     return GetCard.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [GetCard] to a JSON string.
//   String toJson() => json.encode(toMap());

//   GetCard copyWith({
//     int? statusCode,
//     String? status,
//     String? message,
//     Payload? payload,
//   }) {
//     return GetCard(
//       statusCode: statusCode ?? this.statusCode,
//       status: status ?? this.status,
//       message: message ?? this.message,
//       payload: payload ?? this.payload,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     if (other is! GetCard) return false;
//     final mapEquals = const DeepCollectionEquality().equals;
//     return mapEquals(other.toMap(), toMap());
//   }

//   @override
//   int get hashCode =>
//       statusCode.hashCode ^
//       status.hashCode ^
//       message.hashCode ^
//       payload.hashCode;
// }
