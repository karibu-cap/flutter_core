/// The type of number.
enum TypeOfNumber {
  /// The orange service.
  orangeNumber,

  /// The mtn  service.
  mtnNumber,

  /// The camtel service.
  camtelNumber,

  /// The nexttel service.
  nexttelNumber,
}

/// The list of phone number available.
class Gateways {
  /// The native mtn mobile money gateway.
  static const mtnNumberGateway = Gateways._(
    key: 'mtn_momo',
    assetPath: 'assets/icons/payment_mtn_icon.png',
    gatewayName: 'MTN MOMO',
    typeOfNumber: TypeOfNumber.mtnNumber,
  );

  /// The native orange money gateway.
  static const orangeNumberGateway = Gateways._(
    key: 'orange_money',
    assetPath: 'assets/icons/payment_orange_icon.png',
    gatewayName: 'ORANGE MONEY',
    typeOfNumber: TypeOfNumber.orangeNumber,
  );

  /// The native camtel gateway.
  static const camtelNumberGateway = Gateways._(
    key: 'camtel',
    assetPath: 'assets/icons/camtel.png',
    gatewayName: 'CAMTEL',
    typeOfNumber: TypeOfNumber.camtelNumber,
  );

  /// The native nexttel gateway.
  static const nexttelNumberGateway = Gateways._(
    key: 'nexttel',
    assetPath: 'assets/icons/nexttel.png',
    gatewayName: 'NEXTTEL',
    typeOfNumber: TypeOfNumber.nexttelNumber,
  );

  /// The key-value pairs of all available gateways.
  static final data = <String, Gateways>{
    orangeNumberGateway.key: orangeNumberGateway,
    mtnNumberGateway.key: mtnNumberGateway,
    camtelNumberGateway.key: camtelNumberGateway,
    nexttelNumberGateway.key: nexttelNumberGateway,
  };

  /// The unique identifier for a payment gateways.
  final String key;

  /// The path to the gateway image asset.
  final String assetPath;

  /// The name of the gateway.
  final String gatewayName;

  /// The payment service.
  final TypeOfNumber typeOfNumber;

  const Gateways._({
    required this.key,
    required this.typeOfNumber,
    required this.assetPath,
    required this.gatewayName,
  });
}

/// Useful static functions for phone numbers.
abstract class PhoneNumber {
  /// Default country code.
  static const String defaultCountryCode = '+237';

  /// List of supported country codes.
  static const List<String> countryCodesList = [
    '+237',
  ];

  /// Remove the noise like space, dash  and  parenthesis inside
  /// the phone  number.
  /// [number] param is [required] and must be the phone number.
  /// [tag] if  present must be the  valid regular expression and
  /// all match will be removed in [String] result.
  static String purify({required String number, RegExp? tag}) {
    tag ??= RegExp(r' *-*\)*\(*');

    return number.replaceAll(tag, '');
  }

  /// Returns whether the [phoneNumber] parameter is a valid phone number
  /// according to the associated gateway service.
  static bool isValidGateWayPhoneNumber(
    Gateways gateway,
    String phoneNumber,
  ) {
    switch (gateway.typeOfNumber) {
      case TypeOfNumber.orangeNumber:
        {
          return RegExp(r'^((\+)?237)?(69\d{7}$|65[5-9]\d{6}$)')
              .hasMatch(purify(number: phoneNumber));
        }
      case TypeOfNumber.mtnNumber:
        {
          return RegExp(r'^((\+)?237)?(67\d{7}$|68\d{7}$|65[0-4]\d{6}$)')
              .hasMatch(purify(number: phoneNumber));
        }
      case TypeOfNumber.camtelNumber:
        {
          return RegExp(r'^((\+)?237)?(620\d{6}$)')
              .hasMatch(purify(number: phoneNumber));
        }
      case TypeOfNumber.nexttelNumber:
        {
          return RegExp(r'^((\+)?237)?(66\d{7}$)')
              .hasMatch(purify(number: phoneNumber));
        }

      default:
        {
          return false;
        }
    }
  }

  /// Checks if the phone number is valid.
  static bool isValidPhoneNumber(
    String phoneNumber,
  ) {
    bool isValidPhoneNumber = false;

    Gateways.data.forEach((key, value) {
      if (isValidGateWayPhoneNumber(value, phoneNumber)) {
        isValidPhoneNumber = true;
      }
    });

    return isValidPhoneNumber;
  }

  /// Returns the gateway of the number.
  static Gateways? getGateway(String number) {
    if (isValidGateWayPhoneNumber(Gateways.mtnNumberGateway, number)) {
      return Gateways.mtnNumberGateway;
    }
    if (isValidGateWayPhoneNumber(Gateways.orangeNumberGateway, number)) {
      return Gateways.orangeNumberGateway;
    }
    if (isValidGateWayPhoneNumber(Gateways.camtelNumberGateway, number)) {
      return Gateways.camtelNumberGateway;
    }
    if (isValidGateWayPhoneNumber(Gateways.nexttelNumberGateway, number)) {
      return Gateways.nexttelNumberGateway;
    }

    return null;
  }
}
