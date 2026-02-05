part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();
}


class NotiTokenSentEvent extends NotificationEvent{
  SendTokenPayload payload;
  NotiTokenSentEvent(this.payload);
  @override
  // TODO: implement props
  List<Object?> get props => [payload];

}
