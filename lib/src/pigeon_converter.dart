/*
 * Version for Flutter
 * © 2022
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

import "dart:io";

import "package:appmetrica_plugin/appmetrica_plugin.dart";
import "package:appmetrica_plugin/src/appmetrica_api_pigeon.dart";
import "package:stack_trace/stack_trace.dart";

extension ReceiptConverter on Receipt {
  ReceiptPigeon toPigeon() => ReceiptPigeon(data: data, signature: signature);
}

extension RevenueConverter on Revenue {
  RevenuePigeon toPigeon() => RevenuePigeon(
        price: price,
        currency: currency,
        productId: productId,
        quantity: quantity,
        payload: payload,
        transactionId: transactionId,
        receipt: receipt?.toPigeon(),
      );
}

List<StackTraceElementPigeon> convertErrorStackTrace(StackTrace stack) {
  final Iterable<StackTraceElementPigeon> backtrace =
      Trace.from(stack).frames.map((Frame element) {
    final int firstDot = element.member?.indexOf(".") ?? -1;
    final String? className =
        firstDot >= 0 ? element.member?.substring(0, firstDot) : null;
    final String? methodName = element.member?.substring(firstDot + 1);
    return StackTraceElementPigeon(
      className: className ?? "",
      methodName: methodName ?? "",
      fileName: element.library,
      line: element.line ?? 0,
      column: element.column ?? 0,
    );
  });
  return backtrace.toList(growable: false);
}

extension AppMetricaErrorDescriptionSubstitutor on AppMetricaErrorDescription? {
  AppMetricaErrorDescription tryToAddCurrentTrace() {
    if (this == null) {
      return AppMetricaErrorDescription.fromCurrentStackTrace();
    } else {
      return this!;
    }
  }
}

extension AppMetricaErrorDescriptionSerializer on AppMetricaErrorDescription {
  ErrorDetailsPigeon toPigeon() =>
      convertErrorDetails(type ?? "", message, stackTrace);
}

ErrorDetailsPigeon convertErrorDetails(
  String clazz,
  String? msg,
  StackTrace? stack,
) =>
    ErrorDetailsPigeon(
      exceptionClass: clazz,
      message: msg,
      dartVersion: Platform.version,
      backtrace: stack != null
          ? convertErrorStackTrace(stack)
          : <StackTraceElementPigeon?>[],
    );

extension LocationConverter on Location {
  LocationPigeon toPigeon() => LocationPigeon(
        latitude: latitude,
        longitude: longitude,
        provider: provider,
        altitude: altitude,
        accuracy: accuracy,
        course: course,
        speed: speed,
        timestamp: timestamp,
      );
}

extension PreloadInfoConverter on PreloadInfo {
  PreloadInfoPigeon toPigeon() =>
      PreloadInfoPigeon(trackingId: trackingId, additionalInfo: additionalInfo);
}

extension ConfigConverter on AppMetricaConfig {
  AppMetricaConfigPigeon toPigeon() => AppMetricaConfigPigeon(
        apiKey: apiKey,
        anrMonitoring: anrMonitoring,
        anrMonitoringTimeout: anrMonitoringTimeout,
        appBuildNumber: appBuildNumber,
        appEnvironment: appEnvironment,
        appOpenTrackingEnabled: appOpenTrackingEnabled,
        appVersion: appVersion,
        crashReporting: crashReporting,
        customHosts: customHosts,
        dataSendingEnabled: dataSendingEnabled,
        deviceType: deviceType,
        dispatchPeriodSeconds: dispatchPeriodSeconds,
        errorEnvironment: errorEnvironment,
        firstActivationAsUpdate: firstActivationAsUpdate,
        location: location?.toPigeon(),
        locationTracking: locationTracking,
        logs: logs,
        maxReportsCount: maxReportsCount,
        maxReportsInDatabaseCount: maxReportsInDatabaseCount,
        nativeCrashReporting: nativeCrashReporting,
        preloadInfo: preloadInfo?.toPigeon(),
        revenueAutoTrackingEnabled: revenueAutoTrackingEnabled,
        sessionTimeout: sessionTimeout,
        sessionsAutoTrackingEnabled: sessionsAutoTrackingEnabled,
        userProfileID: userProfileID,
      );
}

extension ReporterConfigConverter on ReporterConfig {
  ReporterConfigPigeon toPigeon() => ReporterConfigPigeon(
        apiKey: apiKey,
        appEnvironment: appEnvironment,
        dataSendingEnabled: dataSendingEnabled,
        dispatchPeriodSeconds: dispatchPeriodSeconds,
        logs: logs,
        maxReportsCount: maxReportsCount,
        maxReportsInDatabaseCount: maxReportsInDatabaseCount,
        sessionTimeout: sessionTimeout,
        userProfileID: userProfileID,
      );
}

final Map<AdType, AdTypePigeon> adTypeToPigeon = <AdType, AdTypePigeon>{
  AdType.UNKNOWN: AdTypePigeon.UNKNOWN,
  AdType.NATIVE: AdTypePigeon.NATIVE,
  AdType.BANNER: AdTypePigeon.BANNER,
  AdType.REWARDED: AdTypePigeon.REWARDED,
  AdType.INTERSTITIAL: AdTypePigeon.INTERSTITIAL,
  AdType.MREC: AdTypePigeon.MREC,
  AdType.OTHER: AdTypePigeon.OTHER,
};

extension AdRevenueConverter on AdRevenue {
  AdRevenuePigeon toPigeon() => AdRevenuePigeon(
        adRevenue: adRevenue,
        currency: currency,
        adType: adTypeToPigeon[adType],
        adNetwork: adNetwork,
        adUnitId: adUnitId,
        adUnitName: adUnitName,
        adPlacementId: adPlacementId,
        adPlacementName: adPlacementName,
        precision: precision,
        payload: payload,
      );
}
