class AnalyticsResponse {
  final String status;
  final String message;
  final Payload payload;

  AnalyticsResponse({
    required this.status,
    required this.message,
    required this.payload,
  });

  factory AnalyticsResponse.fromJson(Map<String, dynamic> json) {
    return AnalyticsResponse(
      status: json['status'],
      message: json['message'],
      payload: Payload.fromJson(json['payload']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'payload': payload.toJson(),
    };
  }
}

class Payload {
  final Analytics analytics;

  Payload({
    required this.analytics,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      analytics: Analytics.fromJson(json['analytics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'analytics': analytics.toJson(),
    };
  }
}

class Analytics {
  final int totalViews;
  final int totalShares;
  final int totalContacts;
  final int totalPhone;
  final int totalEmail;
  final int totalConnection;
  final int totalQRCode;
  final int totalSocialLink;
  final DeviceDistribution deviceDistribution;
  final DeviceUserAgent deviceUserAgent;
  final GeoDistribution getGeoDistribution;
  final TopPerformingCards topPerformingCards;
  final Comparison comparison;
  final InteractionCounts interactionCounts;

  Analytics({
    required this.totalViews,
    required this.totalShares,
    required this.totalContacts,
    required this.totalPhone,
    required this.totalEmail,
    required this.totalConnection,
    required this.totalQRCode,
    required this.totalSocialLink,
    required this.deviceDistribution,
    required this.deviceUserAgent,
    required this.getGeoDistribution,
    required this.topPerformingCards,
    required this.comparison,
    required this.interactionCounts,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) {
    return Analytics(
      totalViews: json['totalViews'],
      totalShares: json['totalShares'],
      totalContacts: json['totalContacts'],
      totalPhone: json['totalPhone'],
      totalEmail: json['totalEmail'],
      totalConnection: json['totalConnection'],
      totalQRCode: json['totalQRCode'],
      totalSocialLink: json['totalSocialLink'],
      deviceDistribution:
          DeviceDistribution.fromJson(json['deviceDistribution']),
      deviceUserAgent: DeviceUserAgent.fromJson(json['deviceUserAgent']),
      getGeoDistribution: GeoDistribution.fromJson(json['getGeoDistribution']),
      topPerformingCards:
          TopPerformingCards.fromJson(json['topPerformingCards']),
      comparison: Comparison.fromJson(json['comparison']),
      interactionCounts: InteractionCounts.fromJson(json['interactionCounts']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalViews': totalViews,
      'totalShares': totalShares,
      'totalContacts': totalContacts,
      'totalPhone': totalPhone,
      'totalEmail': totalEmail,
      'totalConnection': totalConnection,
      'totalQRCode': totalQRCode,
      'totalSocialLink': totalSocialLink,
      'deviceDistribution': deviceDistribution.toJson(),
      'deviceUserAgent': deviceUserAgent.toJson(),
      'getGeoDistribution': getGeoDistribution.toJson(),
      'topPerformingCards': topPerformingCards.toJson(),
      'comparison': comparison.toJson(),
      'interactionCounts': interactionCounts.toJson(),
    };
  }
}

class DeviceDistribution {
  final List<DeviceInfoDistribution> deviceInfoDistribution;

  DeviceDistribution({
    required this.deviceInfoDistribution,
  });

  factory DeviceDistribution.fromJson(Map<String, dynamic> json) {
    return DeviceDistribution(
      deviceInfoDistribution: (json['deviceInfoDistribution'] as List)
          .map((e) => DeviceInfoDistribution.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceInfoDistribution':
          deviceInfoDistribution.map((e) => e.toJson()).toList(),
    };
  }
}

class DeviceInfoDistribution {
  final String os;
  final String device;
  final int count;
  final String percentage;

  DeviceInfoDistribution({
    required this.os,
    required this.device,
    required this.count,
    required this.percentage,
  });

  factory DeviceInfoDistribution.fromJson(Map<String, dynamic> json) {
    return DeviceInfoDistribution(
      os: json['os'],
      device: json['device'],
      count: json['count'],
      percentage: json['percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'os': os,
      'device': device,
      'count': count,
      'percentage': percentage,
    };
  }
}

class DeviceUserAgent {
  final List<AgentDistribution> agentDistribution;

  DeviceUserAgent({
    required this.agentDistribution,
  });

  factory DeviceUserAgent.fromJson(Map<String, dynamic> json) {
    return DeviceUserAgent(
      agentDistribution: (json['agentDistribution'] as List)
          .map((e) => AgentDistribution.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'agentDistribution': agentDistribution.map((e) => e.toJson()).toList(),
    };
  }
}

class AgentDistribution {
  final String agent;
  final int count;
  final String percentage;

  AgentDistribution({
    required this.agent,
    required this.count,
    required this.percentage,
  });

  factory AgentDistribution.fromJson(Map<String, dynamic> json) {
    return AgentDistribution(
      agent: json['agent'],
      count: json['count'],
      percentage: json['percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'agent': agent,
      'count': count,
      'percentage': percentage,
    };
  }
}

class GeoDistribution {
  final List<GeoDistributionByCountry> geoDistributionByCountry;
  final List<GeoDistributionByContinent> geoDistributionByContinent;

  GeoDistribution({
    required this.geoDistributionByCountry,
    required this.geoDistributionByContinent,
  });

  factory GeoDistribution.fromJson(Map<String, dynamic> json) {
    return GeoDistribution(
      geoDistributionByCountry: (json['geoDistributionByCountry'] as List)
          .map((e) => GeoDistributionByCountry.fromJson(e))
          .toList(),
      geoDistributionByContinent: (json['geoDistributionByContinent'] as List)
          .map((e) => GeoDistributionByContinent.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geoDistributionByCountry':
          geoDistributionByCountry.map((e) => e.toJson()).toList(),
      'geoDistributionByContinent':
          geoDistributionByContinent.map((e) => e.toJson()).toList(),
    };
  }
}

class GeoDistributionByCountry {
  final String country;
  final String continent;
  final int count;
  final String percentage;

  GeoDistributionByCountry({
    required this.country,
    required this.continent,
    required this.count,
    required this.percentage,
  });

  factory GeoDistributionByCountry.fromJson(Map<String, dynamic> json) {
    return GeoDistributionByCountry(
      country: json['country'],
      continent: json['continent'],
      count: json['count'],
      percentage: json['percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'continent': continent,
      'count': count,
      'percentage': percentage,
    };
  }
}

class GeoDistributionByContinent {
  final String continent;
  final int count;
  final String percentage;

  GeoDistributionByContinent({
    required this.continent,
    required this.count,
    required this.percentage,
  });

  factory GeoDistributionByContinent.fromJson(Map<String, dynamic> json) {
    return GeoDistributionByContinent(
      continent: json['continent'],
      count: json['count'],
      percentage: json['percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'continent': continent,
      'count': count,
      'percentage': percentage,
    };
  }
}

class TopPerformingCards {
  final List<TopPerformingCard> topPerformingCards;

  TopPerformingCards({
    required this.topPerformingCards,
  });

  factory TopPerformingCards.fromJson(Map<String, dynamic> json) {
    return TopPerformingCards(
      topPerformingCards: (json['topPerformingCards'] as List)
          .map((e) => TopPerformingCard.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topPerformingCards': topPerformingCards.map((e) => e.toJson()).toList(),
    };
  }
}

class TopPerformingCard {
  final String cardId;
  final String cardName;
  final int interactionCount;
  final String percentage;
  final List<InteractionType> interactionTypes;

  TopPerformingCard({
    required this.cardId,
    required this.cardName,
    required this.interactionCount,
    required this.percentage,
    required this.interactionTypes,
  });

  factory TopPerformingCard.fromJson(Map<String, dynamic> json) {
    return TopPerformingCard(
      cardId: json['cardId'],
      cardName: json['cardName'],
      interactionCount: json['interactionCount'],
      percentage: json['percentage'],
      interactionTypes: (json['interactionTypes'] as List)
          .map((e) => InteractionType.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardId': cardId,
      'cardName': cardName,
      'interactionCount': interactionCount,
      'percentage': percentage,
      'interactionTypes': interactionTypes.map((e) => e.toJson()).toList(),
    };
  }
}

class InteractionType {
  final String type;
  final int count;

  InteractionType({
    required this.type,
    required this.count,
  });

  factory InteractionType.fromJson(Map<String, dynamic> json) {
    return InteractionType(
      type: json['type'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'count': count,
    };
  }
}

class Comparison {
  final ComparisonItem views;
  final ComparisonItem shares;
  final ComparisonItem contacts;
  final ComparisonItem phone;
  final ComparisonItem email;
  final ComparisonItem connection;
  final ComparisonItem qrCode;
  final ComparisonItem socialLink;

  Comparison({
    required this.views,
    required this.shares,
    required this.contacts,
    required this.phone,
    required this.email,
    required this.connection,
    required this.qrCode,
    required this.socialLink,
  });

  factory Comparison.fromJson(Map<String, dynamic> json) {
    return Comparison(
      views: ComparisonItem.fromJson(json['views']),
      shares: ComparisonItem.fromJson(json['shares']),
      contacts: ComparisonItem.fromJson(json['contacts']),
      phone: ComparisonItem.fromJson(json['phone']),
      email: ComparisonItem.fromJson(json['email']),
      connection: ComparisonItem.fromJson(json['connection']),
      qrCode: ComparisonItem.fromJson(json['QRCode']),
      socialLink: ComparisonItem.fromJson(json['socialLink']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'views': views.toJson(),
      'shares': shares.toJson(),
      'contacts': contacts.toJson(),
      'phone': phone.toJson(),
      'email': email.toJson(),
      'connection': connection.toJson(),
      'QRCode': qrCode.toJson(),
      'socialLink': socialLink.toJson(),
    };
  }
}

class ComparisonItem {
  final int current;
  final int lastMonth;
  final int difference;

  ComparisonItem({
    required this.current,
    required this.lastMonth,
    required this.difference,
  });

  factory ComparisonItem.fromJson(Map<String, dynamic> json) {
    return ComparisonItem(
      current: json['current'],
      lastMonth: json['lastMonth'],
      difference: json['difference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'lastMonth': lastMonth,
      'difference': difference,
    };
  }
}

class InteractionCounts {
  final int totalInteractions;

  InteractionCounts({
    required this.totalInteractions,
  });

  factory InteractionCounts.fromJson(Map<String, dynamic> json) {
    return InteractionCounts(
      totalInteractions: json['totalInteractions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalInteractions': totalInteractions,
    };
  }
}
