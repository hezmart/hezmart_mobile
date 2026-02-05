import '../data/models/token_payload.dart';

abstract class NotificationRepository{
  Future <void>sendToken(SendTokenPayload payload);
}