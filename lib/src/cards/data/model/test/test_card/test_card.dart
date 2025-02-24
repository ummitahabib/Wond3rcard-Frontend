import 'payload.dart';

class TestCard {
  int? statusCode;
  String? status;
  String? message;
  Payload? payload;

  TestCard({this.statusCode, this.status, this.message, this.payload});

  factory TestCard.fromJson(Map<String, dynamic> json) => TestCard(
        statusCode: json['statusCode'] as int?,
        status: json['status'] as String?,
        message: json['message'] as String?,
        payload: json['payload'] == null
            ? null
            : Payload.fromJson(json['payload'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'status': status,
        'message': message,
        'payload': payload?.toJson(),
      };
}
