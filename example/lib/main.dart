// ignore_for_file: discarded_futures

/*
 * Version for Flutter
 * © 2022
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

import "package:appmetrica_plugin/appmetrica_plugin.dart";
import "package:appmetrica_plugin_example/.env.dart";
import "package:flutter/material.dart";

AppMetricaConfig get _config => const AppMetricaConfig(key, logs: true);

Future<void> main() async {
  AppMetrica.runZoneGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      AppMetrica.activate(_config);
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("AppMetrica plugin example app"),
          ),
          body: Builder(
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListView(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      AppMetrica.reportEvent("Event name");
                    },
                    child: const Text("Report Event"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppMetrica.reportError(
                        message: "Error message",
                        errorDescription:
                            AppMetricaErrorDescription.fromCurrentStackTrace(
                          message: "Error message",
                          type: "Error type",
                        ),
                      ).ignore();
                    },
                    child: const Text("Report Error"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppMetrica.reportUnhandledException(
                        AppMetricaErrorDescription.fromCurrentStackTrace(
                          message: "Error message",
                          type: "Error type",
                        ),
                      );
                    },
                    child: const Text("Report Unhandled Exception"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await Future.delayed(
                          Duration.zero,
                          () => throw Exception("Error"),
                        );
                      } on Exception catch (e, stacktrace) {
                        await AppMetrica.reportUnhandledException(
                          AppMetricaErrorDescription.fromObjectAndStackTrace(
                            e,
                            stacktrace,
                          ),
                        );
                      }
                    },
                    child: const Text("Catch Throwen Error"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppMetrica.reportAppOpen("https://appmetrica.yandex.com");
                    },
                    child: const Text("Report App Open"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppMetrica.reportReferralUrl(
                        "https://appmetrica.yandex.com",
                      );
                    },
                    child: const Text("Report Referral Url"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppMetrica.setLocationTracking(true);
                    },
                    child: const Text("Set Location Tracking"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppMetrica.setDataSendingEnabled(true);
                    },
                    child: const Text("Set Data Sending Enabled"),
                  ),
                  const ElevatedButton(
                    onPressed: AppMetrica.sendEventsBuffer,
                    child: Text("Send Events Buffer"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String version = await AppMetrica.libraryVersion;
                      if (context.mounted) {
                        _showSnackBar(context, "Library version $version");
                      }
                    },
                    child: const Text("Get library version"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(content),
          duration: const Duration(seconds: 5),
        ),
      );
  }
}
