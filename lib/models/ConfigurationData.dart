class ConfigurationData {
  final String label;
  final String? type;
  final String url;
  final int numberOfServices;
  final String? securityType;
  final String securityCode;
  final String consumerKey;
  final String consumerSecret;

  ConfigurationData({
    required this.label,
    required this.type,
    required this.url,
    required this.numberOfServices,
    required this.securityType,
    required this.securityCode,
    required this.consumerKey,
    required this.consumerSecret,
  });
}
