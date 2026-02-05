part of 'notification_bloc.dart';

sealed class MyNotificationEvent extends Equatable {
  const MyNotificationEvent();
}


class NotiTokenSentEvent extends MyNotificationEvent{
  SendTokenPayload payload;
  NotiTokenSentEvent(this.payload);
  @override
  // TODO: implement props
  List<Object?> get props => [payload];

}
