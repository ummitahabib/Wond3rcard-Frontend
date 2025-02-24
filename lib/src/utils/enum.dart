enum InteractionType {
  view,
  share,
  save,
  phone,
  email,
  contact,
  connection,
  qrCode,
  socialLink,
}

extension InteractionTypeExtension on InteractionType {
  // Convert enum to string
  String get value {
    switch (this) {
      case InteractionType.view:
        return 'view';
      case InteractionType.share:
        return 'share';
      case InteractionType.save:
        return 'save';
      case InteractionType.phone:
        return 'phone';
      case InteractionType.email:
        return 'email';
      case InteractionType.contact:
        return 'contact';
      case InteractionType.connection:
        return 'connection';
      case InteractionType.qrCode:
        return 'qr-code';
      case InteractionType.socialLink:
        return 'social-link';
    }
  }

  // Convert string to enum
  static InteractionType fromValue(String value) {
    switch (value) {
      case 'view':
        return InteractionType.view;
      case 'share':
        return InteractionType.share;
      case 'save':
        return InteractionType.save;
      case 'phone':
        return InteractionType.phone;
      case 'email':
        return InteractionType.email;
      case 'contact':
        return InteractionType.contact;
      case 'connection':
        return InteractionType.connection;
      case 'qr-code':
        return InteractionType.qrCode;
      case 'social-link':
        return InteractionType.socialLink;
      default:
        throw ArgumentError('Invalid InteractionType: $value');
    }
  }
}
