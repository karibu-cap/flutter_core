import 'package:logging/logging.dart';

import 'remote_config.dart';

/// Fallback implementation of remote config.
class RemoteConfigNoopImplementation implements RemoteConfig {
  final _log = Logger('RemoteConfigNoopImplementation');
  final _errorMessage = 'Unexpected call to RemoteConfig no-op.'
      'RemoteConfig.init() must be called before it is used';

  @override
  Future<void> fetchAndActivate() async {
    _log.severe(_errorMessage, null, StackTrace.current);
  }

  @override
  Future<void> enableDebugMode() async {
    _log.severe(_errorMessage, null, StackTrace.current);
  }

  @override
  bool getBool(String key) {
    _log.severe(_errorMessage, null, StackTrace.current);

    return false;
  }

  @override
  double getDouble(String key) {
    _log.severe(_errorMessage, null, StackTrace.current);

    return 0;
  }

  @override
  int getInt(String key) {
    _log.severe(_errorMessage, null, StackTrace.current);

    return 0;
  }

  @override
  String getString(String key) {
    _log.severe(_errorMessage, null, StackTrace.current);

    return '';
  }

  @override
  Map<String, dynamic> getMap(String key) {
    _log.severe(_errorMessage, null, StackTrace.current);

    return {};
  }

  @override
  Map<String, dynamic>? getAll() {
    _log.severe(_errorMessage, null, StackTrace.current);

    return {};
  }
}
