// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return _ApiResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiResponse {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Payload get payload => throw _privateConstructorUsedError;

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseCopyWith<ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<$Res> {
  factory $ApiResponseCopyWith(
          ApiResponse value, $Res Function(ApiResponse) then) =
      _$ApiResponseCopyWithImpl<$Res, ApiResponse>;
  @useResult
  $Res call({String status, String message, Payload payload});

  $PayloadCopyWith<$Res> get payload;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<$Res, $Val extends ApiResponse>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? payload = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Payload,
    ) as $Val);
  }

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PayloadCopyWith<$Res> get payload {
    return $PayloadCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiResponseImplCopyWith<$Res>
    implements $ApiResponseCopyWith<$Res> {
  factory _$$ApiResponseImplCopyWith(
          _$ApiResponseImpl value, $Res Function(_$ApiResponseImpl) then) =
      __$$ApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String message, Payload payload});

  @override
  $PayloadCopyWith<$Res> get payload;
}

/// @nodoc
class __$$ApiResponseImplCopyWithImpl<$Res>
    extends _$ApiResponseCopyWithImpl<$Res, _$ApiResponseImpl>
    implements _$$ApiResponseImplCopyWith<$Res> {
  __$$ApiResponseImplCopyWithImpl(
      _$ApiResponseImpl _value, $Res Function(_$ApiResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? payload = null,
  }) {
    return _then(_$ApiResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Payload,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseImpl implements _ApiResponse {
  const _$ApiResponseImpl(
      {required this.status, required this.message, required this.payload});

  factory _$ApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponseImplFromJson(json);

  @override
  final String status;
  @override
  final String message;
  @override
  final Payload payload;

  @override
  String toString() {
    return 'ApiResponse(status: $status, message: $message, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, payload);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      __$$ApiResponseImplCopyWithImpl<_$ApiResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseImplToJson(
      this,
    );
  }
}

abstract class _ApiResponse implements ApiResponse {
  const factory _ApiResponse(
      {required final String status,
      required final String message,
      required final Payload payload}) = _$ApiResponseImpl;

  factory _ApiResponse.fromJson(Map<String, dynamic> json) =
      _$ApiResponseImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  Payload get payload;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Payload _$PayloadFromJson(Map<String, dynamic> json) {
  return _Payload.fromJson(json);
}

/// @nodoc
mixin _$Payload {
  List<User> get users => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  /// Serializes this Payload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayloadCopyWith<Payload> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadCopyWith<$Res> {
  factory $PayloadCopyWith(Payload value, $Res Function(Payload) then) =
      _$PayloadCopyWithImpl<$Res, Payload>;
  @useResult
  $Res call({List<User> users, int total, int page, int limit});
}

/// @nodoc
class _$PayloadCopyWithImpl<$Res, $Val extends Payload>
    implements $PayloadCopyWith<$Res> {
  _$PayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? total = null,
    Object? page = null,
    Object? limit = null,
  }) {
    return _then(_value.copyWith(
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayloadImplCopyWith<$Res> implements $PayloadCopyWith<$Res> {
  factory _$$PayloadImplCopyWith(
          _$PayloadImpl value, $Res Function(_$PayloadImpl) then) =
      __$$PayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<User> users, int total, int page, int limit});
}

/// @nodoc
class __$$PayloadImplCopyWithImpl<$Res>
    extends _$PayloadCopyWithImpl<$Res, _$PayloadImpl>
    implements _$$PayloadImplCopyWith<$Res> {
  __$$PayloadImplCopyWithImpl(
      _$PayloadImpl _value, $Res Function(_$PayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? total = null,
    Object? page = null,
    Object? limit = null,
  }) {
    return _then(_$PayloadImpl(
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayloadImpl implements _Payload {
  const _$PayloadImpl(
      {required final List<User> users,
      required this.total,
      required this.page,
      required this.limit})
      : _users = users;

  factory _$PayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayloadImplFromJson(json);

  final List<User> _users;
  @override
  List<User> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  final int total;
  @override
  final int page;
  @override
  final int limit;

  @override
  String toString() {
    return 'Payload(users: $users, total: $total, page: $page, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayloadImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_users), total, page, limit);

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayloadImplCopyWith<_$PayloadImpl> get copyWith =>
      __$$PayloadImplCopyWithImpl<_$PayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayloadImplToJson(
      this,
    );
  }
}

abstract class _Payload implements Payload {
  const factory _Payload(
      {required final List<User> users,
      required final int total,
      required final int page,
      required final int limit}) = _$PayloadImpl;

  factory _Payload.fromJson(Map<String, dynamic> json) = _$PayloadImpl.fromJson;

  @override
  List<User> get users;
  @override
  int get total;
  @override
  int get page;
  @override
  int get limit;

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayloadImplCopyWith<_$PayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  UserTier get userTier => throw _privateConstructorUsedError;
  ActiveSubscription get activeSubscription =>
      throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get fcmToken => throw _privateConstructorUsedError;
  String get userRole => throw _privateConstructorUsedError;
  bool get is2FAEnabled => throw _privateConstructorUsedError;
  bool get mfaEnabled => throw _privateConstructorUsedError;
  String get userStatus => throw _privateConstructorUsedError;
  bool get isSoftDeleted => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  String get userType => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  List<dynamic> get organizations => throw _privateConstructorUsedError;
  String? get stripeCustomerId => throw _privateConstructorUsedError;
  String? get paystackCustomerId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  int get v => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {UserTier userTier,
      ActiveSubscription activeSubscription,
      String id,
      String username,
      String email,
      String password,
      String fcmToken,
      String userRole,
      bool is2FAEnabled,
      bool mfaEnabled,
      String userStatus,
      bool isSoftDeleted,
      bool isVerified,
      String userType,
      String refreshToken,
      List<dynamic> organizations,
      String? stripeCustomerId,
      String? paystackCustomerId,
      DateTime createdAt,
      DateTime updatedAt,
      int v});

  $UserTierCopyWith<$Res> get userTier;
  $ActiveSubscriptionCopyWith<$Res> get activeSubscription;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userTier = null,
    Object? activeSubscription = null,
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? fcmToken = null,
    Object? userRole = null,
    Object? is2FAEnabled = null,
    Object? mfaEnabled = null,
    Object? userStatus = null,
    Object? isSoftDeleted = null,
    Object? isVerified = null,
    Object? userType = null,
    Object? refreshToken = null,
    Object? organizations = null,
    Object? stripeCustomerId = freezed,
    Object? paystackCustomerId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? v = null,
  }) {
    return _then(_value.copyWith(
      userTier: null == userTier
          ? _value.userTier
          : userTier // ignore: cast_nullable_to_non_nullable
              as UserTier,
      activeSubscription: null == activeSubscription
          ? _value.activeSubscription
          : activeSubscription // ignore: cast_nullable_to_non_nullable
              as ActiveSubscription,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      userRole: null == userRole
          ? _value.userRole
          : userRole // ignore: cast_nullable_to_non_nullable
              as String,
      is2FAEnabled: null == is2FAEnabled
          ? _value.is2FAEnabled
          : is2FAEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      mfaEnabled: null == mfaEnabled
          ? _value.mfaEnabled
          : mfaEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      userStatus: null == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as String,
      isSoftDeleted: null == isSoftDeleted
          ? _value.isSoftDeleted
          : isSoftDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      organizations: null == organizations
          ? _value.organizations
          : organizations // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      stripeCustomerId: freezed == stripeCustomerId
          ? _value.stripeCustomerId
          : stripeCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      paystackCustomerId: freezed == paystackCustomerId
          ? _value.paystackCustomerId
          : paystackCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserTierCopyWith<$Res> get userTier {
    return $UserTierCopyWith<$Res>(_value.userTier, (value) {
      return _then(_value.copyWith(userTier: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActiveSubscriptionCopyWith<$Res> get activeSubscription {
    return $ActiveSubscriptionCopyWith<$Res>(_value.activeSubscription,
        (value) {
      return _then(_value.copyWith(activeSubscription: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserTier userTier,
      ActiveSubscription activeSubscription,
      String id,
      String username,
      String email,
      String password,
      String fcmToken,
      String userRole,
      bool is2FAEnabled,
      bool mfaEnabled,
      String userStatus,
      bool isSoftDeleted,
      bool isVerified,
      String userType,
      String refreshToken,
      List<dynamic> organizations,
      String? stripeCustomerId,
      String? paystackCustomerId,
      DateTime createdAt,
      DateTime updatedAt,
      int v});

  @override
  $UserTierCopyWith<$Res> get userTier;
  @override
  $ActiveSubscriptionCopyWith<$Res> get activeSubscription;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userTier = null,
    Object? activeSubscription = null,
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? fcmToken = null,
    Object? userRole = null,
    Object? is2FAEnabled = null,
    Object? mfaEnabled = null,
    Object? userStatus = null,
    Object? isSoftDeleted = null,
    Object? isVerified = null,
    Object? userType = null,
    Object? refreshToken = null,
    Object? organizations = null,
    Object? stripeCustomerId = freezed,
    Object? paystackCustomerId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? v = null,
  }) {
    return _then(_$UserImpl(
      userTier: null == userTier
          ? _value.userTier
          : userTier // ignore: cast_nullable_to_non_nullable
              as UserTier,
      activeSubscription: null == activeSubscription
          ? _value.activeSubscription
          : activeSubscription // ignore: cast_nullable_to_non_nullable
              as ActiveSubscription,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      userRole: null == userRole
          ? _value.userRole
          : userRole // ignore: cast_nullable_to_non_nullable
              as String,
      is2FAEnabled: null == is2FAEnabled
          ? _value.is2FAEnabled
          : is2FAEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      mfaEnabled: null == mfaEnabled
          ? _value.mfaEnabled
          : mfaEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      userStatus: null == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as String,
      isSoftDeleted: null == isSoftDeleted
          ? _value.isSoftDeleted
          : isSoftDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      organizations: null == organizations
          ? _value._organizations
          : organizations // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      stripeCustomerId: freezed == stripeCustomerId
          ? _value.stripeCustomerId
          : stripeCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      paystackCustomerId: freezed == paystackCustomerId
          ? _value.paystackCustomerId
          : paystackCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.userTier,
      required this.activeSubscription,
      required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.fcmToken,
      required this.userRole,
      required this.is2FAEnabled,
      required this.mfaEnabled,
      required this.userStatus,
      required this.isSoftDeleted,
      required this.isVerified,
      required this.userType,
      required this.refreshToken,
      required final List<dynamic> organizations,
      this.stripeCustomerId,
      this.paystackCustomerId,
      required this.createdAt,
      required this.updatedAt,
      required this.v})
      : _organizations = organizations;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final UserTier userTier;
  @override
  final ActiveSubscription activeSubscription;
  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String password;
  @override
  final String fcmToken;
  @override
  final String userRole;
  @override
  final bool is2FAEnabled;
  @override
  final bool mfaEnabled;
  @override
  final String userStatus;
  @override
  final bool isSoftDeleted;
  @override
  final bool isVerified;
  @override
  final String userType;
  @override
  final String refreshToken;
  final List<dynamic> _organizations;
  @override
  List<dynamic> get organizations {
    if (_organizations is EqualUnmodifiableListView) return _organizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_organizations);
  }

  @override
  final String? stripeCustomerId;
  @override
  final String? paystackCustomerId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final int v;

  @override
  String toString() {
    return 'User(userTier: $userTier, activeSubscription: $activeSubscription, id: $id, username: $username, email: $email, password: $password, fcmToken: $fcmToken, userRole: $userRole, is2FAEnabled: $is2FAEnabled, mfaEnabled: $mfaEnabled, userStatus: $userStatus, isSoftDeleted: $isSoftDeleted, isVerified: $isVerified, userType: $userType, refreshToken: $refreshToken, organizations: $organizations, stripeCustomerId: $stripeCustomerId, paystackCustomerId: $paystackCustomerId, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.userTier, userTier) ||
                other.userTier == userTier) &&
            (identical(other.activeSubscription, activeSubscription) ||
                other.activeSubscription == activeSubscription) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.userRole, userRole) ||
                other.userRole == userRole) &&
            (identical(other.is2FAEnabled, is2FAEnabled) ||
                other.is2FAEnabled == is2FAEnabled) &&
            (identical(other.mfaEnabled, mfaEnabled) ||
                other.mfaEnabled == mfaEnabled) &&
            (identical(other.userStatus, userStatus) ||
                other.userStatus == userStatus) &&
            (identical(other.isSoftDeleted, isSoftDeleted) ||
                other.isSoftDeleted == isSoftDeleted) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            const DeepCollectionEquality()
                .equals(other._organizations, _organizations) &&
            (identical(other.stripeCustomerId, stripeCustomerId) ||
                other.stripeCustomerId == stripeCustomerId) &&
            (identical(other.paystackCustomerId, paystackCustomerId) ||
                other.paystackCustomerId == paystackCustomerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userTier,
        activeSubscription,
        id,
        username,
        email,
        password,
        fcmToken,
        userRole,
        is2FAEnabled,
        mfaEnabled,
        userStatus,
        isSoftDeleted,
        isVerified,
        userType,
        refreshToken,
        const DeepCollectionEquality().hash(_organizations),
        stripeCustomerId,
        paystackCustomerId,
        createdAt,
        updatedAt,
        v
      ]);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final UserTier userTier,
      required final ActiveSubscription activeSubscription,
      required final String id,
      required final String username,
      required final String email,
      required final String password,
      required final String fcmToken,
      required final String userRole,
      required final bool is2FAEnabled,
      required final bool mfaEnabled,
      required final String userStatus,
      required final bool isSoftDeleted,
      required final bool isVerified,
      required final String userType,
      required final String refreshToken,
      required final List<dynamic> organizations,
      final String? stripeCustomerId,
      final String? paystackCustomerId,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final int v}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  UserTier get userTier;
  @override
  ActiveSubscription get activeSubscription;
  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get password;
  @override
  String get fcmToken;
  @override
  String get userRole;
  @override
  bool get is2FAEnabled;
  @override
  bool get mfaEnabled;
  @override
  String get userStatus;
  @override
  bool get isSoftDeleted;
  @override
  bool get isVerified;
  @override
  String get userType;
  @override
  String get refreshToken;
  @override
  List<dynamic> get organizations;
  @override
  String? get stripeCustomerId;
  @override
  String? get paystackCustomerId;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  int get v;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserTier _$UserTierFromJson(Map<String, dynamic> json) {
  return _UserTier.fromJson(json);
}

/// @nodoc
mixin _$UserTier {
  String get plan => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String? get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this UserTier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserTier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserTierCopyWith<UserTier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserTierCopyWith<$Res> {
  factory $UserTierCopyWith(UserTier value, $Res Function(UserTier) then) =
      _$UserTierCopyWithImpl<$Res, UserTier>;
  @useResult
  $Res call(
      {String plan, String status, String? transactionId, String? expiresAt});
}

/// @nodoc
class _$UserTierCopyWithImpl<$Res, $Val extends UserTier>
    implements $UserTierCopyWith<$Res> {
  _$UserTierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserTier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plan = null,
    Object? status = null,
    Object? transactionId = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserTierImplCopyWith<$Res>
    implements $UserTierCopyWith<$Res> {
  factory _$$UserTierImplCopyWith(
          _$UserTierImpl value, $Res Function(_$UserTierImpl) then) =
      __$$UserTierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String plan, String status, String? transactionId, String? expiresAt});
}

/// @nodoc
class __$$UserTierImplCopyWithImpl<$Res>
    extends _$UserTierCopyWithImpl<$Res, _$UserTierImpl>
    implements _$$UserTierImplCopyWith<$Res> {
  __$$UserTierImplCopyWithImpl(
      _$UserTierImpl _value, $Res Function(_$UserTierImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserTier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plan = null,
    Object? status = null,
    Object? transactionId = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$UserTierImpl(
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserTierImpl implements _UserTier {
  const _$UserTierImpl(
      {required this.plan,
      required this.status,
      this.transactionId,
      this.expiresAt});

  factory _$UserTierImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserTierImplFromJson(json);

  @override
  final String plan;
  @override
  final String status;
  @override
  final String? transactionId;
  @override
  final String? expiresAt;

  @override
  String toString() {
    return 'UserTier(plan: $plan, status: $status, transactionId: $transactionId, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserTierImpl &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, plan, status, transactionId, expiresAt);

  /// Create a copy of UserTier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserTierImplCopyWith<_$UserTierImpl> get copyWith =>
      __$$UserTierImplCopyWithImpl<_$UserTierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserTierImplToJson(
      this,
    );
  }
}

abstract class _UserTier implements UserTier {
  const factory _UserTier(
      {required final String plan,
      required final String status,
      final String? transactionId,
      final String? expiresAt}) = _$UserTierImpl;

  factory _UserTier.fromJson(Map<String, dynamic> json) =
      _$UserTierImpl.fromJson;

  @override
  String get plan;
  @override
  String get status;
  @override
  String? get transactionId;
  @override
  String? get expiresAt;

  /// Create a copy of UserTier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserTierImplCopyWith<_$UserTierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActiveSubscription _$ActiveSubscriptionFromJson(Map<String, dynamic> json) {
  return _ActiveSubscription.fromJson(json);
}

/// @nodoc
mixin _$ActiveSubscription {
  String? get provider => throw _privateConstructorUsedError;
  String? get subscriptionId => throw _privateConstructorUsedError;
  String? get expiryDate => throw _privateConstructorUsedError;

  /// Serializes this ActiveSubscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveSubscriptionCopyWith<ActiveSubscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveSubscriptionCopyWith<$Res> {
  factory $ActiveSubscriptionCopyWith(
          ActiveSubscription value, $Res Function(ActiveSubscription) then) =
      _$ActiveSubscriptionCopyWithImpl<$Res, ActiveSubscription>;
  @useResult
  $Res call({String? provider, String? subscriptionId, String? expiryDate});
}

/// @nodoc
class _$ActiveSubscriptionCopyWithImpl<$Res, $Val extends ActiveSubscription>
    implements $ActiveSubscriptionCopyWith<$Res> {
  _$ActiveSubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = freezed,
    Object? subscriptionId = freezed,
    Object? expiryDate = freezed,
  }) {
    return _then(_value.copyWith(
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionId: freezed == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActiveSubscriptionImplCopyWith<$Res>
    implements $ActiveSubscriptionCopyWith<$Res> {
  factory _$$ActiveSubscriptionImplCopyWith(_$ActiveSubscriptionImpl value,
          $Res Function(_$ActiveSubscriptionImpl) then) =
      __$$ActiveSubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? provider, String? subscriptionId, String? expiryDate});
}

/// @nodoc
class __$$ActiveSubscriptionImplCopyWithImpl<$Res>
    extends _$ActiveSubscriptionCopyWithImpl<$Res, _$ActiveSubscriptionImpl>
    implements _$$ActiveSubscriptionImplCopyWith<$Res> {
  __$$ActiveSubscriptionImplCopyWithImpl(_$ActiveSubscriptionImpl _value,
      $Res Function(_$ActiveSubscriptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = freezed,
    Object? subscriptionId = freezed,
    Object? expiryDate = freezed,
  }) {
    return _then(_$ActiveSubscriptionImpl(
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionId: freezed == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveSubscriptionImpl implements _ActiveSubscription {
  const _$ActiveSubscriptionImpl(
      {this.provider, this.subscriptionId, this.expiryDate});

  factory _$ActiveSubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveSubscriptionImplFromJson(json);

  @override
  final String? provider;
  @override
  final String? subscriptionId;
  @override
  final String? expiryDate;

  @override
  String toString() {
    return 'ActiveSubscription(provider: $provider, subscriptionId: $subscriptionId, expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSubscriptionImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, provider, subscriptionId, expiryDate);

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveSubscriptionImplCopyWith<_$ActiveSubscriptionImpl> get copyWith =>
      __$$ActiveSubscriptionImplCopyWithImpl<_$ActiveSubscriptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveSubscriptionImplToJson(
      this,
    );
  }
}

abstract class _ActiveSubscription implements ActiveSubscription {
  const factory _ActiveSubscription(
      {final String? provider,
      final String? subscriptionId,
      final String? expiryDate}) = _$ActiveSubscriptionImpl;

  factory _ActiveSubscription.fromJson(Map<String, dynamic> json) =
      _$ActiveSubscriptionImpl.fromJson;

  @override
  String? get provider;
  @override
  String? get subscriptionId;
  @override
  String? get expiryDate;

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveSubscriptionImplCopyWith<_$ActiveSubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
