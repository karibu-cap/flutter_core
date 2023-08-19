import 'package:flutter/foundation.dart';
import '../crash_reporting.dart';

/// Interface to handle crash report.
abstract class CrashReportingInterface {
  /// Checks a device for any fatal or non-fatal crash reports that haven't yet
  /// been sent to Crashlytics.
  Future<bool> checkForUnsentReports();

  /// Causes the app to crash (natively).
  ///
  /// This should only be used for testing purposes in cases where you wish to
  /// simulate a native crash to view the results on the Firebase Console.
  void crash();

  /// Queues up all unsent reports on a device for deletion.
  Future<void> deleteUnsentReports();

  /// Logs a message that's included in the next fatal or non-fatal report.
  Future<void> log(String message);

  /// Submits a Crashlytics report of a caught error.
  Future<void> recordError(ErrorRecordParam param);

  /// Submits a Crashlytics report of a non-fatal error
  /// caught by the Flutter framework.
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails);

  /// Queues up all the
  /// reports on a device to send to Crashlytics.
  Future<void> sendUnsentReports();

  /// Sets a custom key and value that are associated with subsequent fatal and
  /// non-fatal reports.
  ///
  /// Multiple calls to this method with the same key update the value
  /// for that key.
  /// The value of any key at the time of a fatal or non-fatal event is
  /// associated with that event. Keys and associated values are visible
  /// in the session view on the Firebase Crashlytics console.
  ///
  /// Accepts a maximum of 64 key/value pairs. New keys beyond that limit are
  /// ignored. Keys or values that exceed 1024 characters are truncated.
  ///
  /// The value can only be a type [int], [num], [String] or [bool].
  Future<void> setCustomKey(String key, Object value);

  /// Records a user ID (identifier) that's associated with subsequent fatal and
  /// non-fatal reports.
  Future<void> setUserIdentifier(String identifier);
}
