import 'package:flutter_test/flutter_test.dart';
import 'package:karibu_core_remote_config/remote_config.dart';

void main() {
  const testConfig = <String, dynamic>{
    'enable_sms_transfer': true,
  };
  group('Retrieve config: ', () {
    RemoteConfig.init(service: RemoteConfigType.fake, defaults: testConfig);

    test('returns boolean options', () async {
      expect(RemoteConfig().getBool('enable_sms_transfer'), true);
    });
  });
}
