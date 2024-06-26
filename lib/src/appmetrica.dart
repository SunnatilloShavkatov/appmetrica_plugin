/*
 * Version for Flutter
 * © 2022
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

import "dart:async";
import "dart:convert";
import "dart:developer" as developer;

import "package:appmetrica_plugin/src/activation_config_holder.dart";
import "package:appmetrica_plugin/src/ad_revenue.dart";
import "package:appmetrica_plugin/src/appmetrica_api_pigeon.dart";
import "package:appmetrica_plugin/src/appmetrica_config.dart";
import "package:appmetrica_plugin/src/deferred_deeplink_result.dart";
import "package:appmetrica_plugin/src/ecommerce_event.dart";
import "package:appmetrica_plugin/src/error_description.dart";
import "package:appmetrica_plugin/src/location.dart";
import "package:appmetrica_plugin/src/pigeon_converter.dart";
import "package:appmetrica_plugin/src/profile/attribute.dart";
import "package:appmetrica_plugin/src/reporter/reporter.dart";
import "package:appmetrica_plugin/src/reporter/reporter_config.dart";
import "package:appmetrica_plugin/src/reporter/reporter_storage.dart";
import "package:appmetrica_plugin/src/revenue.dart";
import "package:appmetrica_plugin/src/startup_params.dart";
import "package:appmetrica_plugin/src/to_dart_converter.dart";
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";

const String _deeplink_plugin_error =
    "Unable to retrieve deeplink from native library";

/// The class contains methods for working with the library.
class AppMetrica {
  AppMetrica._();

  static final ReporterStorage _reporterStorage = ReporterStorage();

  static final AppMetricaPigeon _appMetrica = AppMetricaPigeon();

  // static final _logger = Logger("$appMetricaRootLoggerName.MainFacade");

  /// Initializes the library in the application with the initial configuration [config].
  static Future<void> activate(AppMetricaConfig config) async {
    setUpErrorHandlingWithAppMetrica();
    final ActivationCompleter activationCompleter = ActivationCompleter(config);
    return _appMetrica.activate(config.toPigeon()).then(
          activationCompleter.complete,
          onError: activationCompleter.onError,
        );
  }

  /// Activates reporter with the [config] configuration.
  ///
  /// The reporter must be activated with a configuration that contains an API key different from the API key of the application.
  static Future<void> activateReporter(ReporterConfig config) =>
      _appMetrica.activateReporter(config.toPigeon());

  static Future<void> clearAppEnvironment() =>
      _appMetrica.clearAppEnvironment();

  static Future<void> enableActivityAutoTracking() =>
      _appMetrica.enableActivityAutoTracking();

  /// Returns deviceId
  static Future<String?> get deviceId => _appMetrica.getDeviceId();

  /// Returns the API level of the library (Android).
  static Future<int> get libraryApiLevel => _appMetrica.getLibraryApiLevel();

  /// Returns the current version of the AppMetrica library.
  static Future<String> get libraryVersion => _appMetrica.getLibraryVersion();

  /// Returns an object that implements the Reporter interface for the specified [apiKey].
  ///
  /// Used to send statistics using an API key different from the app's API key.
  static Reporter getReporter(String apiKey) {
    _appMetrica.touchReporter(apiKey).ignore();
    return _reporterStorage.getReporter(apiKey);
  }

  static Future<String?> get uuid => _appMetrica.getUuid();

  /// Suspends the current foreground session.
  ///
  /// Use the method only when session auto-tracking is disabled [AppMetricaConfig.sessionsAutoTracking].
  static Future<void> pauseSession() => _appMetrica.pauseSession();

  static Future<void> putAppEnvironmentValue(String key, String? value) => _appMetrica.putAppEnvironmentValue(key, value);

  /// Adds a [key]-[value] pair to or deletes it from the application error environment. The environment is shown in the crash and error report.
  ///
  /// * The maximum length of the [key] key is 50 characters. If the length is exceeded, the key is truncated to 50 characters.
  /// * The maximum length of the [value] value is 4000 characters. If the length is exceeded, the value is truncated to 4000 characters.
  /// * A maximum of 30 environment pairs of the form {key, value} are allowed. If you try to add the 31st pair, it will be ignored.
  /// * Total size (sum {len(key) + len(value)} for (key, value) in error_environment) - 4500 characters.
  /// * If a new pair exceeds the total size, it will be ignored.
  static Future<void> putErrorEnvironmentValue(String key, String? value) =>
      _appMetrica.putErrorEnvironmentValue(key, value);

  /// Sends information about ad revenue.
  static Future<void> reportAdRevenue(AdRevenue adRevenue) =>
      _appMetrica.reportAdRevenue(adRevenue.toPigeon());

  /// Sends a message about opening the application using [deeplink].
  static Future<void> reportAppOpen(String deeplink) =>
      _appMetrica.reportAppOpen(deeplink);

  /// Sends a message about an e-commerce event.
  static Future<void> reportECommerce(ECommerceEvent event) =>
      _appMetrica.reportECommerce(event.toPigeon());

  /// Sends an error message [message] with the description [errorDescription].
  /// If there is no [errorDescription] description, the current stacktrace will be automatically added.
  static Future<void> reportError(
          {String? message, AppMetricaErrorDescription? errorDescription,}) =>
      _appMetrica.reportError(
          errorDescription.tryToAddCurrentTrace().toPigeon(), message,);

  /// Sends an error message with its own identifier [groupId]. Errors in reports are grouped by it.
  static Future<void> reportErrorWithGroup(String groupId,
          {AppMetricaErrorDescription? errorDescription, String? message,}) =>
      _appMetrica.reportErrorWithGroup(
          groupId, errorDescription?.toPigeon(), message,);

  /// Sends an event message with a short name or description of the event [eventName].
  static Future<void> reportEvent(String eventName) =>
      _appMetrica.reportEvent(eventName);

  /// Sends an event message in JSON format [attributesJson] as a string and a short name or description of the event [eventName].
  static Future<void> reportEventWithJson(
          String eventName, String? attributesJson,) =>
      _appMetrica.reportEventWithJson(eventName, attributesJson);

  /// Sends an event message as a set of attributes [attributes] Map and a short name or description of the event [eventName].
  static Future<void> reportEventWithMap(
          String eventName, Map<String, Object>? attributes,) =>
      _appMetrica.reportEventWithJson(eventName, jsonEncode(attributes));

  /// Sets the [referralUrl] of the application installation.
  ///
  /// The method can be used to track some traffic sources.
  static Future<void> reportReferralUrl(String referralUrl) =>
      _appMetrica.reportReferralUrl(referralUrl);

  /// Sends the purchase information to the AppMetrica server.
  static Future<void> reportRevenue(Revenue revenue) =>
      _appMetrica.reportRevenue(revenue.toPigeon());

  /// Sends an event with an unhandled exception [errorDescription].
  static Future<void> reportUnhandledException(
          AppMetricaErrorDescription errorDescription,) =>
      _appMetrica.reportUnhandledException(errorDescription.toPigeon());

  /// Sends information about updating the user profile using the [userProfile] parameter.
  static Future<void> reportUserProfile(UserProfile userProfile) =>
      _appMetrica.reportUserProfile(userProfile.toPigeon());

  /// Requests a deferred deeplink.
  ///
  /// Relevant only for Android. For iOS, it returns the unknown error.
  static Future<String> requestDeferredDeeplink() =>
      _appMetrica.requestDeferredDeeplink().then((AppMetricaDeferredDeeplinkPigeon value) {
        final AppMetricaDeferredDeeplinkErrorPigeon? error = value.error;
        if (error != null &&
            error.reason != AppMetricaDeferredDeeplinkReasonPigeon.NO_ERROR) {
          throw DeferredDeeplinkRequestException(
              _deferredDeeplinkErrortoDart(error.reason),
              error.description,
              error.message,);
        } else if (value.deeplink == null) {
          throw DeferredDeeplinkRequestException(
              DeferredDeeplinkErrorReason.unknown,
              _deeplink_plugin_error,
              error?.message,);
        } else {
          return value.deeplink!;
        }
      });

  /// Requests deferred deeplink parameters.
  ///
  /// Relevant only for Android. For iOS, it returns the unknown error.
  static Future<Map<String, String>> requestDeferredDeeplinkParameters() =>
      _appMetrica.requestDeferredDeeplinkParameters().then((AppMetricaDeferredDeeplinkParametersPigeon value) {
        final AppMetricaDeferredDeeplinkErrorPigeon? error = value.error;
        if (error != null &&
            error.reason != AppMetricaDeferredDeeplinkReasonPigeon.NO_ERROR) {
          throw DeferredDeeplinkRequestException(
              _deferredDeeplinkErrortoDart(error.reason),
              error.description,
              error.message,);
        } else if (value.parameters == null) {
          throw DeferredDeeplinkRequestException(
              DeferredDeeplinkErrorReason.unknown,
              _deeplink_plugin_error,
              error?.message,);
        } else {
          return value.parameters!
              .map((String? key, String? value) => MapEntry(key!, value!));
        }
      });

  static Future<StartupParams> requestStartupParams(List<String>? params) =>
      _appMetrica
          .requestStartupParams(params ?? <String?>[])
          .then((StartupParamsPigeon value) => value.toDart());

  /// Resumes the foreground session or creates a new one if the session timeout has expired.
  ///
  /// Use the method only when session auto-tracking is disabled [AppMetricaConfig.sessionsAutoTracking].
  static Future<void> resumeSession() => _appMetrica.resumeSession();

  /// Sends saved events from the buffer.
  static Future<void> sendEventsBuffer() => _appMetrica.sendEventsBuffer();

  /// Enables/disables sending statistics to the AppMetrica server.
  ///
  /// Disabling sending for the main API key also disables sending data from all reporters
  /// that were initialized with another API key.
  static Future<void> setDataSendingEnabled(bool enabled) =>
      _appMetrica.setDataSendingEnabled(enabled);

  /// Sets its own device location information using the [location] parameter.
  static Future<void> setLocation(Location? location) =>
      _appMetrica.setLocation(location?.toPigeon());

  /// Enables/disables sending device location information using the [enabled].
  /// The default value for Android is false, for iOS is true.
  static Future<void> setLocationTracking(bool enabled) =>
      _appMetrica.setLocationTracking(enabled);

  /// Sets the ID for the user profile using the [userProfileID] parameter.
  ///
  /// If Profile Id sending is not configured, predefined attributes are not displayed in the web interface.
  static Future<void> setUserProfileID(String? userProfileID) =>
      _appMetrica.setUserProfileID(userProfileID);

  // utilitary methods

  /// Runs [callback] in its own error zone created by [runZonedGuarded](https://api.flutter.dev/flutter/dart-async/runZonedGuarded.html),
  /// and reports all exceptions to AppMetrica.
  static void runZoneGuarded(VoidCallback callback) {
    runZonedGuarded(() {
      WidgetsFlutterBinding.ensureInitialized();
      callback();
    }, (Object err, StackTrace stack) {
      developer.log("error caught by Zone", error: err, stackTrace: stack);
      if (ActivationConfigHolder.lastActivationConfig != null) {
        _appMetrica
            .reportUnhandledException(convertErrorDetails(
                err.runtimeType.toString(), err.toString(), stack,),)
            .ignore();
      }
    });
  }
}

bool _crashHandlingActivated = false;

void setUpErrorHandlingWithAppMetrica() {
  if (!_crashHandlingActivated) {
    _crashHandlingActivated = true;
    final FlutterExceptionHandler? prev = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) async {
      developer.log(
        "error caught by Zone",
        error: details.exception,
        stackTrace: details.stack,
      );
      await AppMetrica._appMetrica.reportUnhandledException(
        convertErrorDetails(
          details.exception.runtimeType.toString(),
          details.summary.toString(),
          details.stack,
        ),
      );
      if (prev != null) {
        prev(details);
      }
    };
  }
}

DeferredDeeplinkErrorReason _deferredDeeplinkErrortoDart(
    AppMetricaDeferredDeeplinkReasonPigeon error,) {
  switch (error) {
    case AppMetricaDeferredDeeplinkReasonPigeon.NOT_A_FIRST_LAUNCH:
      return DeferredDeeplinkErrorReason.notAFirstLaunch;
    case AppMetricaDeferredDeeplinkReasonPigeon.PARSE_ERROR:
      return DeferredDeeplinkErrorReason.parseError;
    case AppMetricaDeferredDeeplinkReasonPigeon.UNKNOWN:
      return DeferredDeeplinkErrorReason.unknown;
    case AppMetricaDeferredDeeplinkReasonPigeon.NO_REFERRER:
      return DeferredDeeplinkErrorReason.noReferrer;
    default:
      return DeferredDeeplinkErrorReason.unknown;
  }
}
