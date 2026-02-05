part of 'notification_bloc.dart';

sealed class MyNotificationState extends Equatable {
  const MyNotificationState();
}

final class NotificationInitial extends MyNotificationState {
  @override
  List<Object> get props => [];
}


class NotificationLoadingState extends MyNotificationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class NotificationSuccessState extends MyNotificationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class NotificationFailiureState extends MyNotificationState{
  String error;
  NotificationFailiureState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
