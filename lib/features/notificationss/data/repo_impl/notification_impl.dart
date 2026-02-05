import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/services/network/url_config.dart';

import '../../domain/notification_repo.dart';
import '../models/token_payload.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  NetworkService networkService;
  NotificationRepositoryImpl(this.networkService);
  @override
  Future<void> sendToken(SendTokenPayload payload) async {
    var response = await networkService.call(
      UrlConfig.tokensend,
      RequestMethod.post,
      data: payload.toJson(),
    );
    return response.data;
  }
}
