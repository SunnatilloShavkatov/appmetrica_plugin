/*
 * Version for Flutter
 * © 2022
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

/// The class to store Ad Revenue data. You can set:
/// * [adRevenue] - amount of money received via ad revenue (it cannot be negative);
/// * [currency] - Currency in which money from [adRevenue] is represented;
/// * [adType] - ad type;
/// * [adNetwork] - ad network. Maximum length is 100 symbols;
/// * [adUnitId] - id of ad unit. Maximum length is 100 symbols;
/// * [adUnitName] - name of ad unit. Maximum length is 100 symbols;
/// * [adPlacementId] - id of ad placement. Maximum length is 100 symbols;
/// * [adPlacementName] - name of ad placement. Maximum length is 100 symbols;
/// * [precision] - precision. Example: "publisher_defined", "estimated". Maximum length is 100 symbols;
/// * [payload] - arbitrary payload: additional info represented as key-value pairs. Maximum size is 30 KB.
class AdRevenue {

  /// Creates an object with information about income from in-app purchases. The parameters [adRevenue], [currency] are required.
  AdRevenue({
    required this.adRevenue,
    required this.currency,
    this.adType,
    this.adNetwork,
    this.adUnitId,
    this.adUnitName,
    this.adPlacementId,
    this.adPlacementName,
    this.precision,
    this.payload,
  });
  final String adRevenue;
  final String currency;
  final AdType? adType;
  final String? adNetwork;
  final String? adUnitId;
  final String? adUnitName;
  final String? adPlacementId;
  final String? adPlacementName;
  final String? precision;
  final Map<String, String>? payload;
}

/// Enum containing possible Ad Type values.
enum AdType {
  UNKNOWN,
  NATIVE,
  BANNER,
  REWARDED,
  INTERSTITIAL,
  MREC,
  OTHER,
}
