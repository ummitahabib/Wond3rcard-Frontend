class InteractionRequest {
  final String cardId;
  final String interactionType;
  final String ipAddress;
  final String cardOwnerId;
  final Interactor? interactor;
  final DeviceInfo? deviceInfo;

  InteractionRequest({
    required this.cardId,
    required this.interactionType,
    required this.ipAddress,
    required this.cardOwnerId,
    this.interactor,
    this.deviceInfo,
  });

  factory InteractionRequest.fromJson(Map<String, dynamic> json) {
    return InteractionRequest(
      cardId: json['cardId'],
      interactionType: json['interactionType'],
      ipAddress: json['ipAddress'],
      cardOwnerId: json['cardOwnerId'],
      interactor: Interactor.fromJson(json['interactor']),
      deviceInfo: DeviceInfo.fromJson(json['deviceInfo']),
    );
  }

  // Convert InteractionRequest to JSON
  Map<String, dynamic> toJson() {
    return {
      'cardId': cardId,
      'interactionType': interactionType,
      'ipAddress': ipAddress,
      'cardOwnerId': cardOwnerId,
      'interactor': interactor!.toJson(),
      'deviceInfo': deviceInfo!.toJson(),
    };
  }
}

class Interactor {
  final bool isWonderCardUser;
  final String uid;
  final String fullName;

  Interactor({
    required this.isWonderCardUser,
    required this.uid,
    required this.fullName,
  });

  // Convert JSON to Interactor
  factory Interactor.fromJson(Map<String, dynamic> json) {
    return Interactor(
      isWonderCardUser: json['isWonderCardUser'],
      uid: json['uid'],
      fullName: json['fullName'],
    );
  }

  // Convert Interactor to JSON
  Map<String, dynamic> toJson() {
    return {
      'isWonderCardUser': isWonderCardUser,
      'uid': uid,
      'fullName': fullName,
    };
  }
}

class DeviceInfo {
  final String agent;
  final String os;
  final String device;

  DeviceInfo({
    required this.agent,
    required this.os,
    required this.device,
  });

  // Convert JSON to DeviceInfo
  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      agent: json['agent'],
      os: json['os'],
      device: json['device'],
    );
  }

  // Convert DeviceInfo to JSON
  Map<String, dynamic> toJson() {
    return {
      'agent': agent,
      'os': os,
      'device': device,
    };
  }
}
