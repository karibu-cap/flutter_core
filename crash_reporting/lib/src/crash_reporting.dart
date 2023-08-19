import 'package:flutter/foundation.dart';

import 'crash_reporting_interface.dart';
import 'fake_crash_reporting.dart';
import 'firebase_crash_reporting.dart';

/// Service that provide firebase crashlytics inside an app.
/// Requires to call [CrashReporting.init] method to set the service needed.
abstract class CrashReporting implements CrashReportingInterface {
  static CrashReporterType _reporterType = CrashReporterType.firebase;

  /// Returns an CrashReporting instance.
  factory CrashReporting() {
    switch (_reporterType) {
      case CrashReporterType.firebase:
        return FireBaseCrashReporting();
      case CrashReporterType.fake:
        return FakeCrashReporting();
    }
  }

  /// Initializes the crash reporter to use.
  static void init({required CrashReporterType service}) {
    _reporterType = service;
  }
}

/// Enum third party crash reporter used by the system.
enum CrashReporterType {
  /// The firebase crash reporting.
  firebase,

  /// An Empty crash reporting.
  fake,
}

/// The type of argument to provide in a [recordError] method.
class ErrorRecordParam {
  /// The exception provided with the error.
  final dynamic exception;

  /// The stack trace of error.
  final StackTrace? stack;

  /// The error message.
  final dynamic reason;

  /// Additional information for diagnostic.
  final Iterable<DiagnosticsNode> information;

  /// Is true when we need to print error details.
  final bool? printDetails;

  /// Is true when the error is fatal.
  final bool fatal;

  /// Constructs a new [ErrorRecordParam].
  ErrorRecordParam({
    this.exception,
    this.stack,
    this.reason,
    this.information = const [],
    this.printDetails,
    this.fatal = false,
  });
}
