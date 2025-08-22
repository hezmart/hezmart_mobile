import 'package:hezmart/app_config.dart';

import 'core/services/network/url_config.dart';



void main() {
  AppConfig.initializeAndRunInstance(
      appName: 'Hezmart', enviroment: Environment.development);

  //
  // var ap = AuthRepositoryImpl(injector.get());
  //
  // ap.authenticateWithApple();
}
