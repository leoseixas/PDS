import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseInitialize {
  Future<void> initializeParse() async {
    await Parse().initialize(
      'o3WtzOsjVrwELkAfkRWLS1DctDQeAcYWipWSPT2X',
      'https://parseapi.back4app.com/',
      clientKey: 'JSBULSt2Jnvqi15a5yvFiF7TqA5a35cBZoeFrbFo',
      autoSendSessionId: true,
      debug: true,
    );
  }
}
