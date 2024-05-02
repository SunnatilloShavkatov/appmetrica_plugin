/*
 * Version for Flutter
 * © 2022
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

import "dart:convert";

import "package:appmetrica_plugin/src/ad_revenue.dart";
import "package:appmetrica_plugin/src/appmetrica_api_pigeon.dart";
import "package:appmetrica_plugin/src/ecommerce_event.dart";
import "package:appmetrica_plugin/src/error_description.dart";
import "package:appmetrica_plugin/src/pigeon_converter.dart";
import "package:appmetrica_plugin/src/profile/attribute.dart";
import "package:appmetrica_plugin/src/reporter/reporter.dart";
import "package:appmetrica_plugin/src/revenue.dart";

class ReporterImpl implements Reporter {

  ReporterImpl(this._apiKey);
  static final ReporterPigeon _reporterPigeon = ReporterPigeon();

  final String _apiKey;

  @override
  Future<void> clearAppEnvironment() =>
      _reporterPigeon.clearAppEnvironment(_apiKey);

  @override
  Future<void> pauseSession() =>
      _reporterPigeon.pauseSession(_apiKey);

  @override
  Future<void> putAppEnvironmentValue(String key, String? value) =>
      _reporterPigeon.putAppEnvironmentValue(_apiKey, key, value);

  @override
  Future<void> reportAdRevenue(AdRevenue adRevenue) =>
      _reporterPigeon.reportAdRevenue(_apiKey, adRevenue.toPigeon());

  @override
  Future<void> reportECommerce(ECommerceEvent event) =>
      _reporterPigeon.reportECommerce(_apiKey, event.toPigeon());

  @override
  Future<void> reportError({
    String? message,
    AppMetricaErrorDescription? errorDescription,
  }) =>
      _reporterPigeon.reportError(_apiKey, errorDescription.tryToAddCurrentTrace().toPigeon(), message);

  @override
  Future<void> reportErrorWithGroup(
      String groupId, {
        AppMetricaErrorDescription? errorDescription,
        String? message,
      }) =>
      _reporterPigeon.reportErrorWithGroup(_apiKey, groupId, errorDescription?.toPigeon(), message);

  @override
  Future<void> reportEvent(String eventName) =>
      _reporterPigeon.reportEvent(_apiKey, eventName);

  @override
  Future<void> reportEventWithJson(String eventName, String? attributesJson) =>
      _reporterPigeon.reportEventWithJson(_apiKey, eventName, attributesJson);

  @override
  Future<void> reportEventWithMap(
      String eventName,
      Map<String, Object>? attributes,
  ) =>
      _reporterPigeon.reportEventWithJson(_apiKey, eventName, jsonEncode(attributes));

  @override
  Future<void> reportRevenue(Revenue revenue) =>
      _reporterPigeon.reportRevenue(_apiKey, revenue.toPigeon());

  @override
  Future<void> reportUnhandledException(AppMetricaErrorDescription error) =>
      _reporterPigeon.reportUnhandledException(_apiKey, error.toPigeon());

  @override
  Future<void> reportUserProfile(UserProfile userProfile) =>
      _reporterPigeon.reportUserProfile(_apiKey, userProfile.toPigeon());

  @override
  Future<void> resumeSession() =>
      _reporterPigeon.resumeSession(_apiKey);

  @override
  Future<void> sendEventsBuffer() =>
      _reporterPigeon.sendEventsBuffer(_apiKey);

  @override
  Future<void> setDataSendingEnabled(bool enabled) =>
      _reporterPigeon.setDataSendingEnabled(_apiKey, enabled);

  @override
  Future<void> setUserProfileID(String? userProfileID) =>
      _reporterPigeon.setUserProfileID(_apiKey, userProfileID);
}
