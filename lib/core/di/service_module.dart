import 'package:get_it/get_it.dart';

import '../services/location_service/location_service.dart';
import '../services/network/network_service.dart';
import '../services/network/url_config.dart';


void setup(GetIt getIt) {
  getIt.registerLazySingleton<NetworkService>(
      () => NetworkService(baseUrl: UrlConfig.coreBaseUrl));
  getIt.registerLazySingleton<LocationService>(() => LocationService());
}
