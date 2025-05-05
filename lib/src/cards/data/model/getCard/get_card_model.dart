import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_card_model.freezed.dart';
part 'get_card_model.g.dart';

@freezed
class GetCardModel with _$GetCardModel {
  factory GetCardModel({
    @JsonKey(name: "_id") required String id,
    required String cardType,
    required String ownerId,
    required String cardName,
    required String firstName,
    required String lastName,
    String? otherName,
    required bool active,
    @JsonKey(name: "videoUrl") String? videoUrl,
    @JsonKey(name: "cardPictureUrl") String? cardPictureUrl,
    @JsonKey(name: "cardCoverUrl") String? cardCoverUrl,
    required ContactInfo contactInfo,
  }) = _GetCardModel;

  factory GetCardModel.fromJson(Map<String, dynamic> json) => _$GetCardModelFromJson(json);
}

@freezed
class ContactInfo with _$ContactInfo {
  factory ContactInfo({
    required String email,
    required String phone,
    required String website,
  }) = _ContactInfo;

  factory ContactInfo.fromJson(Map<String, dynamic> json) => _$ContactInfoFromJson(json);
}