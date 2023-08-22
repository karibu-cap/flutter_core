/// Interface for accessing Remote Config values.
abstract class RemoteConfigInterface {
  /// Activates the fetched config, makes fetched key-values take effect.
  Future<void> fetchAndActivate();

  /// Enables a mode that allows multiple fetches per hour without throttling.
  Future<void> enableDebugMode();

  /// Gets the value corresponding to the key as a bool.
  ///
  /// Returns false if the key doesn't exist or the value isn't a boolean.
  bool getBool(String key);

  /// Gets the value corresponding to the key as a double.
  ///
  /// Returns 0 if the key doesn't exist or the value isn't a double.
  double getDouble(String key);

  /// Gets the value corresponding to the key as an int.
  ///
  /// Returns 0 if the key doesn't exist or the value isn't an integer.
  int getInt(String key);

  /// Gets the value corresponding to the key as a String.
  ///
  /// Returns an empty string if the key doesn't exist or the value is null.
  String getString(String key);

  /// Gets the value corresponding to the key as a Map.
  ///
  /// Returns an empty Map if the key doesn't exist or the value is null.
  Map<String, dynamic> getMap(String key);

  /// Gets all value's remote config.
  Map<String, dynamic>? getAll();
}
