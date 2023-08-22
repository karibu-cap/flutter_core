import 'dart:convert';

import 'remote_config.dart';

/// Fake implementation of RemoteConfig for testing use only.
class RemoteConfigFakeImplementation implements RemoteConfig {
  final Map<dynamic, dynamic> _config;

  /// Constructs the RemoteConfigFakeImplementation.
  RemoteConfigFakeImplementation(this._config);

  @override
  Future<void> fetchAndActivate() {
    return Future.value();
  }

  @override
  Future<void> enableDebugMode() {
    return Future.value();
  }

  @override
  bool getBool(String key) {
    return _config[key] == true;
  }

  @override
  double getDouble(String key) {
    return _config[key] ?? 0;
  }

  @override
  int getInt(String key) {
    return _config[key] ?? 0;
  }

  @override
  String getString(String key) {
    return _config[key] ?? '';
  }

  @override
  Map<String, dynamic> getMap(String key) {
    return json.decode(_config[key]) ?? {};
  }

  @override
  Map<String, dynamic>? getAll() {
    return _config as Map<String, dynamic>;
  }
}
