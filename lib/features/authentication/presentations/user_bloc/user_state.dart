part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class UserCachedState extends UserState {
  final HezmartUser user;

   UserCachedState(this.user);

  @override
  List<Object> get props => [user];
}
