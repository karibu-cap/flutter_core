import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logging/logging.dart';

import 'remote_config.dart' as Core;

/// Firebase implementation of RemoteConfig.
class RemoteConfigFirebaseImplementation implements Core.RemoteConfig {
  final _log = Logger('RemoteConfigFirebaseImplementation');
  final _remoteConfig = FirebaseRemoteConfig.instance;

  /// Constructs a RemoteConfigImplementation using the provided default values.
  RemoteConfigFirebaseImplementation(Map<String, dynamic> defaults) {
    _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        minimumFetchInterval: Duration(minutes: 15),
        fetchTimeout: Duration(minutes: 1),
      ),
    );

    _remoteConfig.setDefaults(defaults);
  }

  @override
  Future<void> fetchAndActivate() async {
    try {
      final completed = await _remoteConfig.fetchAndActivate();
      _log.info('fetchAndActivate completed with response $completed');
    } on FirebaseException catch (e) {
      _log.warning('failed to fetch and activate configs: ${e.toString()}');
    }
  }

  @override
  Map<String, dynamic>? getAll() {
    final Map<String, dynamic> result = {};
    try {
      _remoteConfig
          .getAll()
          .forEach((key, value) => result[key] = value.asString());
      return result;
    } on FirebaseException catch (e) {
      _log.warning('failed to get all remote configs: ${e.toString()}');

      return null;
    }
  }

  @override
  Future<void> enableDebugMode() async {
    const minimumFetchInterval = Duration(seconds: 5);

    return _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        minimumFetchInterval: minimumFetchInterval,
        fetchTimeout: Duration(minutes: 1),
      ),
    );
  }

  @override
  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  @override
  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }

  @override
  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  @override
  String getString(String key) {
    return _remoteConfig.getString(key);
  }

  @override
  Map<String, dynamic> getMap(String key) {
    return json.decode(_remoteConfig.getString(key));
  }
}
