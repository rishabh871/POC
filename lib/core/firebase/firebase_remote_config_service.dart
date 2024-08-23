import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class FirebaseRemoteConfigService {

  final FirebaseRemoteConfig _remoteConfig;

  FirebaseRemoteConfigService._() : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() => _instance ??= FirebaseRemoteConfigService._();


  String getString(String key) => _remoteConfig.getString(key);
  bool getBool(String key) =>_remoteConfig.getBool(key);
  int getInt(String key) =>_remoteConfig.getInt(key);
  double getDouble(String key) =>_remoteConfig.getDouble(key);

  Future<void> initialize() async {
    await _setConfigSettings();
    await _setDefaults();
    await fetchAndActivate();
  }


  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 12),
    ),
  );

  Future<void> _setDefaults() async => _remoteConfig.setDefaults(
    const {
      FirebaseRemoteConfigKeys.welcomeMessage: 'Hey there, this message is coming from local defaults.',
      FirebaseRemoteConfigKeys.androidVersionCode: 1,
      FirebaseRemoteConfigKeys.iosVersionCode: 1,
    },
  );

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      debugPrint('The config has been updated.');
    } else {
      debugPrint('The config is not updated..');
    }
  }
}

class FirebaseRemoteConfigKeys {
  static const String welcomeMessage = 'welcome_message';
  static const String androidVersionCode = 'android_version_code';
  static const String iosVersionCode = 'ios_version_code';
}
