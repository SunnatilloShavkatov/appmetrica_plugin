/*
 * Version for Flutter
 * © 2022
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

import "package:appmetrica_plugin/src/common_utils.dart";
import "package:flutter/foundation.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  test("Set up Crash Handling", () {
    final FlutterExceptionHandler? error = FlutterError.onError;
    setUpErrorHandling();
    expect(FlutterError.onError, isNot(same(error)));
  });

  test("Set up Crash Handling Twice", () {
    setUpErrorHandling();
    final FlutterExceptionHandler? appmetricaHandler = FlutterError.onError;
    expect(FlutterError.onError, same(appmetricaHandler));
  });
}
