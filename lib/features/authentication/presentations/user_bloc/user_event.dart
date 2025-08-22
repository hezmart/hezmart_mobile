part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {}
class UpdateUserEvent extends UserEvent {
  final HezmartUser user;

  UpdateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}
class SaveUserEvent extends UserEvent {
  final HezmartUser appUser;
  // final GoogleResponse googleuser;

  SaveUserEvent(this.appUser, );

  @override
  List<Object?> get props => [appUser];
}

class GetUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class ClearUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}
