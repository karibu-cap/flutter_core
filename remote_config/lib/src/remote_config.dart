import 'remote_config_fake_implementation.dart';
import 'remote_config_firebase_implementation.dart';
import 'remote_config_interface.dart';
import 'remote_config_noop.dart';

/// Service that allows remote configuration of the app.
/// Requires a call to [RemoteConfig.init] to setup the service needed.
abstract class RemoteConfig implements RemoteConfigInterface {
  static RemoteConfig _instance = RemoteConfigNoopImplementation();

  /// Returns a RemoteConfig instance.
  factory RemoteConfig() {
    return _instance;
  }

  /// Initializes the remote config system.
  static Future<void> init({
    required RemoteConfigType service,
    required Map<String, dynamic> defaults,
  }) async {
    switch (service) {
      case RemoteConfigType.firebase:
        _instance = RemoteConfigFirebaseImplementation(defaults);
        break;
      case RemoteConfigType.fake:
        _instance = RemoteConfigFakeImplementation(defaults);
    }

    return _instance.fetchAndActivate();
  }
}

/// Remote config backend service.
enum RemoteConfigType {
  /// Firebase remote config.
  firebase,

  /// Remote config using static values.
  fake,
}
