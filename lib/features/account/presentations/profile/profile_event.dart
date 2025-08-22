part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}
class GetProfileEvent extends ProfileEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class EditprofileEvent extends ProfileEvent {
  String firstname;
  String lastname;
  String number;
  String address;
  String state;

  EditprofileEvent(this.firstname, this.lastname, this.number, this.address,
      this.state);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
