/*
 * Version for Flutter
 * © 2022
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

import "package:appmetrica_plugin/src/reporter/reporter.dart";
import "package:appmetrica_plugin/src/reporter/reporter_impl.dart";

class ReporterStorage {
  final Map<String, Reporter> _map = <String, Reporter>{};

  Reporter getReporter(String apiKey) =>
      _map.putIfAbsent(apiKey, () => ReporterImpl(apiKey));
}
