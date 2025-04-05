// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetCardModel _$GetCardModelFromJson(Map<String, dynamic> json) {
  return _GetCardModel.fromJson(json);
}

/// @nodoc
mixin _$GetCardModel {
  @JsonKey(name: "_id")
  String get id => throw _privateConstructorUsedError;
  String get cardType => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get cardName => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get otherName => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  @JsonKey(name: "videoUrl")
  String? get videoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "cardPictureUrl")
  String? get cardPictureUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "cardCoverUrl")
  String? get cardCoverUrl => throw _privateConstructorUsedError;
  ContactInfo get contactInfo => throw _privateConstructorUsedError;

  /// Serializes this GetCardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetCardModelCopyWith<GetCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCardModelCopyWith<$Res> {
  factory $GetCardModelCopyWith(
          GetCardModel value, $Res Function(GetCardModel) then) =
      _$GetCardModelCopyWithImpl<$Res, GetCardModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      String cardType,
      String ownerId,
      String cardName,
      String firstName,
      String lastName,
      String? otherName,
      bool active,
      @JsonKey(name: "videoUrl") String? videoUrl,
      @JsonKey(name: "cardPictureUrl") String? cardPictureUrl,
      @JsonKey(name: "cardCoverUrl") String? cardCoverUrl,
      ContactInfo contactInfo});

  $ContactInfoCopyWith<$Res> get contactInfo;
}

/// @nodoc
class _$GetCardModelCopyWithImpl<$Res, $Val extends GetCardModel>
    implements $GetCardModelCopyWith<$Res> {
  _$GetCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetCardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cardType = null,
    Object? ownerId = null,
    Object? cardName = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? otherName = freezed,
    Object? active = null,
    Object? videoUrl = freezed,
    Object? cardPictureUrl = freezed,
    Object? cardCoverUrl = freezed,
    Object? contactInfo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      cardName: null == cardName
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      otherName: freezed == otherName
          ? _value.otherName
          : otherName // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      cardPictureUrl: freezed == cardPictureUrl
          ? _value.cardPictureUrl
          : cardPictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      cardCoverUrl: freezed == cardCoverUrl
          ? _value.cardCoverUrl
          : cardCoverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as ContactInfo,
    ) as $Val);
  }

  /// Create a copy of GetCardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactInfoCopyWith<$Res> get contactInfo {
    return $ContactInfoCopyWith<$Res>(_value.contactInfo, (value) {
      return _then(_value.copyWith(contactInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetCardModelImplCopyWith<$Res>
    implements $GetCardModelCopyWith<$Res> {
  factory _$$GetCardModelImplCopyWith(
          _$GetCardModelImpl value, $Res Function(_$GetCardModelImpl) then) =
      __$$GetCardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      String cardType,
      String ownerId,
      String cardName,
      String firstName,
      String lastName,
      String? otherName,
      bool active,
      @JsonKey(name: "videoUrl") String? videoUrl,
      @JsonKey(name: "cardPictureUrl") String? cardPictureUrl,
      @JsonKey(name: "cardCoverUrl") String? cardCoverUrl,
      ContactInfo contactInfo});

  @override
  $ContactInfoCopyWith<$Res> get contactInfo;
}

/// @nodoc
class __$$GetCardModelImplCopyWithImpl<$Res>
    extends _$GetCardModelCopyWithImpl<$Res, _$GetCardModelImpl>
    implements _$$GetCardModelImplCopyWith<$Res> {
  __$$GetCardModelImplCopyWithImpl(
      _$GetCardModelImpl _value, $Res Function(_$GetCardModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetCardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cardType = null,
    Object? ownerId = null,
    Object? cardName = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? otherName = freezed,
    Object? active = null,
    Object? videoUrl = freezed,
    Object? cardPictureUrl = freezed,
    Object? cardCoverUrl = freezed,
    Object? contactInfo = null,
  }) {
    return _then(_$GetCardModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      cardName: null == cardName
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      otherName: freezed == otherName
          ? _value.otherName
          : otherName // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      cardPictureUrl: freezed == cardPictureUrl
          ? _value.cardPictureUrl
          : cardPictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      cardCoverUrl: freezed == cardCoverUrl
          ? _value.cardCoverUrl
          : cardCoverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as ContactInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetCardModelImpl implements _GetCardModel {
  _$GetCardModelImpl(
      {@JsonKey(name: "_id") required this.id,
      required this.cardType,
      required this.ownerId,
      required this.cardName,
      required this.firstName,
      required this.lastName,
      this.otherName,
      required this.active,
      @JsonKey(name: "videoUrl") this.videoUrl,
      @JsonKey(name: "cardPictureUrl") this.cardPictureUrl,
      @JsonKey(name: "cardCoverUrl") this.cardCoverUrl,
      required this.contactInfo});

  factory _$GetCardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetCardModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String id;
  @override
  final String cardType;
  @override
  final String ownerId;
  @override
  final String cardName;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? otherName;
  @override
  final bool active;
  @override
  @JsonKey(name: "videoUrl")
  final String? videoUrl;
  @override
  @JsonKey(name: "cardPictureUrl")
  final String? cardPictureUrl;
  @override
  @JsonKey(name: "cardCoverUrl")
  final String? cardCoverUrl;
  @override
  final ContactInfo contactInfo;

  @override
  String toString() {
    return 'GetCardModel(id: $id, cardType: $cardType, ownerId: $ownerId, cardName: $cardName, firstName: $firstName, lastName: $lastName, otherName: $otherName, active: $active, videoUrl: $videoUrl, cardPictureUrl: $cardPictureUrl, cardCoverUrl: $cardCoverUrl, contactInfo: $contactInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCardModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.cardName, cardName) ||
                other.cardName == cardName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.otherName, otherName) ||
                other.otherName == otherName) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.cardPictureUrl, cardPictureUrl) ||
                other.cardPictureUrl == cardPictureUrl) &&
            (identical(other.cardCoverUrl, cardCoverUrl) ||
                other.cardCoverUrl == cardCoverUrl) &&
            (identical(other.contactInfo, contactInfo) ||
                other.contactInfo == contactInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      cardType,
      ownerId,
      cardName,
      firstName,
      lastName,
      otherName,
      active,
      videoUrl,
      cardPictureUrl,
      cardCoverUrl,
      contactInfo);

  /// Create a copy of GetCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCardModelImplCopyWith<_$GetCardModelImpl> get copyWith =>
      __$$GetCardModelImplCopyWithImpl<_$GetCardModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetCardModelImplToJson(
      this,
    );
  }
}

abstract class _GetCardModel implements GetCardModel {
  factory _GetCardModel(
      {@JsonKey(name: "_id") required final String id,
      required final String cardType,
      required final String ownerId,
      required final String cardName,
      required final String firstName,
      required final String lastName,
      final String? otherName,
      required final bool active,
      @JsonKey(name: "videoUrl") final String? videoUrl,
      @JsonKey(name: "cardPictureUrl") final String? cardPictureUrl,
      @JsonKey(name: "cardCoverUrl") final String? cardCoverUrl,
      required final ContactInfo contactInfo}) = _$GetCardModelImpl;

  factory _GetCardModel.fromJson(Map<String, dynamic> json) =
      _$GetCardModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String get id;
  @override
  String get cardType;
  @override
  String get ownerId;
  @override
  String get cardName;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get otherName;
  @override
  bool get active;
  @override
  @JsonKey(name: "videoUrl")
  String? get videoUrl;
  @override
  @JsonKey(name: "cardPictureUrl")
  String? get cardPictureUrl;
  @override
  @JsonKey(name: "cardCoverUrl")
  String? get cardCoverUrl;
  @override
  ContactInfo get contactInfo;

  /// Create a copy of GetCardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetCardModelImplCopyWith<_$GetCardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContactInfo _$ContactInfoFromJson(Map<String, dynamic> json) {
  return _ContactInfo.fromJson(json);
}

/// @nodoc
mixin _$ContactInfo {
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get website => throw _privateConstructorUsedError;

  /// Serializes this ContactInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactInfoCopyWith<ContactInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactInfoCopyWith<$Res> {
  factory $ContactInfoCopyWith(
          ContactInfo value, $Res Function(ContactInfo) then) =
      _$ContactInfoCopyWithImpl<$Res, ContactInfo>;
  @useResult
  $Res call({String email, String phone, String website});
}

/// @nodoc
class _$ContactInfoCopyWithImpl<$Res, $Val extends ContactInfo>
    implements $ContactInfoCopyWith<$Res> {
  _$ContactInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? phone = null,
    Object? website = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactInfoImplCopyWith<$Res>
    implements $ContactInfoCopyWith<$Res> {
  factory _$$ContactInfoImplCopyWith(
          _$ContactInfoImpl value, $Res Function(_$ContactInfoImpl) then) =
      __$$ContactInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String phone, String website});
}

/// @nodoc
class __$$ContactInfoImplCopyWithImpl<$Res>
    extends _$ContactInfoCopyWithImpl<$Res, _$ContactInfoImpl>
    implements _$$ContactInfoImplCopyWith<$Res> {
  __$$ContactInfoImplCopyWithImpl(
      _$ContactInfoImpl _value, $Res Function(_$ContactInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? phone = null,
    Object? website = null,
  }) {
    return _then(_$ContactInfoImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactInfoImpl implements _ContactInfo {
  _$ContactInfoImpl(
      {required this.email, required this.phone, required this.website});

  factory _$ContactInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactInfoImplFromJson(json);

  @override
  final String email;
  @override
  final String phone;
  @override
  final String website;

  @override
  String toString() {
    return 'ContactInfo(email: $email, phone: $phone, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactInfoImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.website, website) || other.website == website));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, phone, website);

  /// Create a copy of ContactInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactInfoImplCopyWith<_$ContactInfoImpl> get copyWith =>
      __$$ContactInfoImplCopyWithImpl<_$ContactInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactInfoImplToJson(
      this,
    );
  }
}

abstract class _ContactInfo implements ContactInfo {
  factory _ContactInfo(
      {required final String email,
      required final String phone,
      required final String website}) = _$ContactInfoImpl;

  factory _ContactInfo.fromJson(Map<String, dynamic> json) =
      _$ContactInfoImpl.fromJson;

  @override
  String get email;
  @override
  String get phone;
  @override
  String get website;

  /// Create a copy of ContactInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactInfoImplCopyWith<_$ContactInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
