import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kDebugMode) {
      // Ensure errors are printed in debug as well.
      Zone.current.handleUncaughtError(details.exception, details.stack ?? StackTrace.empty);
    }
  };

  runZonedGuarded(
    () => runApp(const App()),
    (error, stackTrace) {
      // In debug this prints to the console; in release you can later wire to Crashlytics/Sentry.
      debugPrint('Uncaught error: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}
