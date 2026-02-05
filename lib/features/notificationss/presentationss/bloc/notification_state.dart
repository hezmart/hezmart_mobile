part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}


class NotificationLoadingState extends NotificationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class NotificationSuccessState extends NotificationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class NotificationFailiureState extends NotificationState{
  String error;
  NotificationFailiureState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
